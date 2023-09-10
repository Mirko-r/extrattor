![onefetch](./onefetch.png)

# Description

![Extrattor](https://github.com/Mirko-r/extrattor/blob/master/Extrattor1.0.png)

A simple bash wrapper to manage one or more archives from the terminal

![Platform](https://img.shields.io/badge/platform%20-Linux-blue) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/Mirko-r/extrattor) ![GitHub](https://img.shields.io/github/license/Mirko-r/extrattor) ![GitHub commit activity](https://img.shields.io/github/commit-activity/y/Mirko-r/extrattor) ![GitHub last commit](https://img.shields.io/github/last-commit/Mirko-r/extrattor) ![GitHub all releases](https://img.shields.io/github/downloads/Mirko-r/extrattor/total) ![AUR version](https://img.shields.io/aur/version/extrattor)

# Installation

## Debian\Ubuntu and derivatives

Soon™ (seriously though, soon)

## Manual

### Stable
- go to [the releases page](https://github.com/Mirko-r/extrattor/releases)
- download the `extrattor.zip` of the version you want
- open your terminal in the folder where you downloaded, extract it and run:

```bash
    cd extrattor
    chmod u+x install.sh
    sudo ./install.sh
```

### Unstable
 
```bash
git clone https://github.com/Mirko-r/extrattor
cd extrattor/extrattor
chmod u+x install.sh
sudo ./install.sh
```

## Sample Usage

### Synopsis

```bash 
    extrattor [option] [archives]
```

### Commands list

| Command                                     | Function                        |
| --------------------------------------------|---------------------------------|
| `extrattor -x </path/to/archive1/2/3> <...>`| Extract one or more arhive      |
| `extrattor -i </path/to/archive1/2/3> <...>`| Get info about archives       	|
| `extrattor -p </path/to/archive1/2/3> <...>`| Protect archives with password	|
| `extrattor -t </path/to/archive1/2/3> <...>`| Test archives comparing the CRC	|
| `extrattor -f </path/to/archive1/2/3> <...>`| Try to fix archives	            |
| `extrattor -v`                              | Print version                   |
| `extrattor -h`                              | Print help                      |
| `extrattor -l`                              | List all compatible formats for each function|

## Contributing

1. [Fork it](<https://github.com/Mirko-r/extrattor/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request