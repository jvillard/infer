# Lab for Infer

## Follow along the lab

```
cd Desktop/infer
git remote add sbmf https://github.com/jvillard/infer.git
git fetch sbmf lab
git checkout -b lab sbmf/lab
export BUILD_MODE=default
./build-infer.sh java
make devsetup
```

See [infer/src/labs/README.md](./infer/src/labs/README.md) for more instructions.

## Installation

To build Infer from source, see [INSTALL.md](./INSTALL.md).

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md).

## License

Infer is BSD-licensed. We also provide an additional patent grant.

Note: Enabling Java support may require you to download and install 
components licensed under the GPL.
