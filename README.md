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

It is recommended to install the prebuilt binary of Extractor:

```bash
git clone https://github.com/Mirko-r/extractor.git
cd extractor/extractor-bin
makepkg
sudo pacman -U <the-package-file-that-makepkg-produces>
```

#### Debian\Ubuntu based 

avialable soon

## Sample Usage

| Command              | Function                                                                              |
| -------------------- | ------------------------------------------------------------------------------------- |
| `extrattor </path/to/file1>  </path/to/file2> <...>`| Extract one or more arhive                                                            |
| `extrattor -v`       | Print version                                                                         |
| `extrattor -h`       | Print help                                                                            |


## To do

<ul>
<li> .deb package for Ubuntu/Debian distros
<li> Man page
</ul>
