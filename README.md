# FreeRTOS-Kernel

This repository contains FreeRTOS kernel source/header files and kernel ports only. This repository is referenced as a submodule in [FreeRTOS/FreeRTOS](https://github.com/FreeRTOS/FreeRTOS) repository, which contains pre-configured demo application projects in the *FreeRTOS/Demo* directory.

## Getting started

The easiest way to use FreeRTOS is to start with one of the pre-configured demo application projects. That way you will have the correct FreeRTOS source files included, and the correct include paths configured.  Once a demo application is building and executing you can remove the demo application files, and start to add in your own application source files.  See the [FreeRTOS Kernel Quick Start Guide](https://www.FreeRTOS.org/FreeRTOS-quick-start-guide.html) for detailed instructions and other useful links.

For more FreeRTOS kernel information, refer to the [Developer Documentation](https://www.FreeRTOS.org/features.html) and [API Reference](https://www.FreeRTOS.org/a00106.html).

### Getting help

If you have any questions or need assistance troubleshooting your FreeRTOS project, we have an active community that can help on the [FreeRTOS Community Support Forum](https://forums.freertos.org).

## Cloning this repository

To clone using HTTPS:

```
git clone https://github.com/FreeRTOS/FreeRTOS-Kernel.git
```

Using SSH:

```
git clone git@github.com:FreeRTOS/FreeRTOS-Kernel.git
```

## Repository structure

- The root of this repository contains the three files that are common to
every port.

- list.c, queue.c and tasks.c. The kernel is contained within these
three files.

- croutine.c implements the optional co-routine functionality, which
is normally only used on very memory limited systems.

- The *./portable* directory contains the files that are specific to a particular microcontroller and/or compiler. See the readme file in the *./portable* directory for more information.


- The *./include* directory contains the real time kernel header files.

### Code Formatting

FreeRTOS files are formatted using the "uncrustify" tool.
The configuration file used by uncrustify can be found in the *.tools/uncrustify.cfg* file. Files that are auto-generated or provided by a 3rd-party may be excluded from uncrustify checks in the .pre-commit-config.yaml file in the root of this repository.

### Trailing Whitespace

Files changed in new commits should have trailing whitespace removed from all lines prior to merging (with the exception of markdown files). Addiitonal exceptions can be added to the .pre-commit-config.yaml file in the root of this repository.

### Line Endings

Files in this repository use either LF or CRLF line endings. As new changes are made, please convert line endings to LF as appropriate and add any exceptions to the .gitattributes file.

### End of File

To improve compatibility with posix utilities, all files should end with an empty line (LF character).

### Spelling

The *.tools/lexicon.txt* file contains words that are not traditionally found in an English dictionary. It is used by the spellchecker to verify the various jargon, variable names, and other odd words used in the FreeRTOS code base. If your pull request fails to pass the spelling check and you believe this is a mistake, then you may add the word to *.tools/lexicon.txt*.

Note: only the FreeRTOS Kernel source files have been checked for proper spelling. When modifying a file in the *portable* directory, you may be prompted to correct spelling in any file which you have modified as part of a pull-request.

### pre-commit

You may run many of the automated checks mentioned above prior to opening a pull request by installing [pre-commit](https://pre-commit.com) and running the pre-commit command from the root directory of this repository.
