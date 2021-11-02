# Description

![Extrattor](https://github.com/Mirko-r/extractor/blob/main/Extrattor1.0.png)

Extractor is a simple Linux utility to extract one or more archives from the terminal

![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/Mirko-r/extractor) ![GitHub](https://img.shields.io/github/license/Mirko-r/extractor) ![GitHub commit activity](https://img.shields.io/github/commit-activity/y/Mirko-r/extractor) ![GitHub last commit](https://img.shields.io/github/last-commit/Mirko-r/extractor) ![GitHub all releases](https://img.shields.io/github/downloads/Mirko-r/extractor/total)

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

available soon

## Sample Usage

| Command              | Function                                                                              |
| -------------------- | ------------------------------------------------------------------------------------- |
| `extrattor -x </path/to/file1>  </path/to/file2> <...>`| Extract one or more arhive                          |
| `extrattor -i </path/to/file1>  </path/to/file2> <...>`| Get info about archives (work only with .zip)       |
| `extrattor -p </path/to/file1>  </path/to/file2> <...>`| Protect archives with password (work only with zip) |
| `extrattor -v`       | Print version                                                                         |
| `extrattor -h`       | Print help                                                                            |

## Release History

* 1.5.0
    * ADD: Add `-i` parameter to get info about archives (only .zip)
    * ADD: Add `-P` parameter to protect archives with password (only .zip)
    * CHANGE: change `-e` paramater to `-x` in order to follow the standard
* 1.1.1
    * FIX: bugfix
* 1.1.0
    * ADD: Add `-e` parameter to extract archives
* 1.0.1
    * FIX: bugfix
* 1.0.0
    * Initial release

## Contributing

1. [Fork it](<https://github.com/Mirko-r/extractor/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request
