# Description

![Extrattor](https://github.com/Mirko-r/extractor/blob/main/Extrattor1.0.png)

Extractor is a simple Linux utility to extract one or more archives from the terminal

![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/Mirko-r/extractor) ![GitHub](https://img.shields.io/github/license/Mirko-r/extractor) ![GitHub commit activity](https://img.shields.io/github/commit-activity/y/Mirko-r/extractor) ![GitHub last commit](https://img.shields.io/github/last-commit/Mirko-r/extractor)

## Portable

You have only to gave execution permission and launch the .sh script

```bash
cd extractor
chmod u+x extrattor.sh
./extrattor.sh
```

## Installation

### Prebuilt Binaries

#### Arch linux based

It is recommended to install one version of the prebuilt binary of Extractor:

- go to [this page](https://github.com/Mirko-r/extractor/releases) and select a release
- download the PKGBUILD
- open your terminal and type:
```bash
makepkg -si
```

#### Debian\Ubuntu based 

available soon

### Github version (unstable)

#### Arch linux based

```bash
git clone https://github.com/Mirko-r/extractor.git
cd extractor/extractor-bin
makepkg -si
```

##### Debian\Ubuntu based

```bash
git clone https://github.com/Mirko-r/extractor.git
cd extractor/extractor
install -Dm0755 extrattor.sh /usr/bin/extrattor
```

## Sample Usage

| Command              | Function                                                                              |
| -------------------- | ------------------------------------------------------------------------------------- |
| `extrattor -e </path/to/file1>  </path/to/file2> <...>`| Extract one or more arhive                                                            |
| `extrattor -v`       | Print version                                                                         |
| `extrattor -h`       | Print help                                                                            |


## To do

<ul>
<li> .deb package for Ubuntu/Debian distros
<li> Man page
<li> -i option to get info about archives
</ul>
