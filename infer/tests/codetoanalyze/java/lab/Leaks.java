/*
 * Copyright (c) 2017 - present Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

package codetoanalyze.java.checkers;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

public class Leaks {

  void basicLeakBad() throws FileNotFoundException {
    new FileInputStream("file.txt");
  }

  void doubleLeakBad() throws FileNotFoundException {
    new FileInputStream("file1.txt");
    new FileInputStream("file2.txt");
  }

  void basicReleaseOk() throws IOException, FileNotFoundException {
    FileInputStream stream = new FileInputStream("file.txt");
    stream.close();
  }

  void acquireTwoForgetOneBad() throws IOException, FileNotFoundException {
    FileInputStream stream1 = new FileInputStream("file.txt");
    FileInputStream stream2 = new FileInputStream("file.txt");
    stream1.close();
  }

  void acquireTwoThenReleaseOk() throws IOException, FileNotFoundException {
    FileInputStream stream1 = new FileInputStream("file.txt");
    FileInputStream stream2 = new FileInputStream("file.txt");
    stream1.close();
    stream2.close();
  }

  void mayLeakBad(Boolean b) throws IOException, FileNotFoundException {
    FileInputStream stream;
    if (b) {
      stream = new FileInputStream("file.txt");
    }
  }

  void choiceCloseOk(Boolean b) throws IOException, FileNotFoundException {
    FileInputStream stream = new FileInputStream("file.txt");
    if (b) {
      stream.close();
    } else {
      stream.close();
    }
  }

  void openCloseLoopOk(String[] files) throws IOException, FileNotFoundException {
    FileInputStream stream;
    for (int i = 0; i < files.length; i++) {
      String file = files[i];
      stream = new FileInputStream(file);
      stream.close();
    }
  }

  void openAllCloseAllLoopOk(String[] files) throws IOException, FileNotFoundException {
    FileInputStream[] streams = new FileInputStream[files.length];
    for (int i = 0; i < files.length; i++) {
      streams[i] = new FileInputStream(files[i]);
    }
    for (int i = 0; i < files.length; i++) {
      streams[i].close();
    }
  }

  /* Interprocedural
  FileInputStream returnResourceOk() throws IOException, FileNotFoundException {
    return new FileInputStream("file.txt");
  }

  FileInputStream returnResourceWrapperOk() throws IOException, FileNotFoundException {
    return returnResourceOk();
  }

  void returnResourceThenCloseOk() throws IOException, FileNotFoundException {
    returnResourceWrapperOk().close();
  }

  int returnResourceThenLeakBad() throws IOException, FileNotFoundException {
    returnResourceWrapperOk(); // warning
    return 0;
  }
  */

  /* access paths
  void acquireTwoThenReleaseOneTwiceBad() throws IOException, FileNotFoundException {
    FileInputStream stream1 = new FileInputStream("file.txt");
    FileInputStream stream2 = new FileInputStream("file.txt");
    stream1.close();
    stream1.close();
  }
  */

  /* aliasing
  void releaseBothOk(FileInputStream stream1, FileInputStream stream2) throws IOException {
    if (stream1 == stream2) {
      stream1.close();
    } else {
      stream1.close();
      stream2.close();
    }
  }
  */

}
