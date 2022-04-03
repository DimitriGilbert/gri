# GRI : Git(hub) Release Installer

Download, extract and make executable binaries downloaded from a git(hub) release.
It is only tested on github with a few repos but works well in those cases as this tool is more of a test for [argbash](https://argbash.io) (it works really well :D )

## Usage

```bash
Usage: gri [--arch ARCH] [--git-server GIT-SERVER] [--secure] [--extract] [--exec] [--source] [--help] <user> <app> <tag> [<output>]

Options:
  -a ARCH, --arch ARCH                    target architecture.
  -g GIT-SERVER, --git-server GIT-SERVER  git server domain [default: $([ -n "$GRI_CONFIG_GIT_SERVER" ]&&echo $GRI_CONFIG_GIT_SERVER||echo 'github.com')].
  --secure                                use ssl connection to git server [default: on].
  --extract                               extract [default: on].
  --exec                                  add execution right [default: on].
  --source                                download source [default: off].
  -h, --help                              Prints help.
```

### Simple

downloads in a folder to $HOME

```bash
gri <github user> <github repo> <version>
# eg
gri DimitriGilbert gri 0.0.1

```

### Choose download directory

```bash
gri <github user> <github repo> <version> <output directory>
# eg
gri DimitriGilbert gri 0.0.1 $HOME/Downloads

```

### Choose target architecture

```bash
gri <github user> <github repo> <version> --arch <architecture>
gri <github user> <github repo> <version> -a <architecture>
# eg
gri barthr redo 0.3.0 $HOME/Downloads -a Linux_X86_64

```

### Choose git service

NOT TESTED

```bash
gri <git service user> <git service repo> <version> --git-server <git service domain (github.com)>
gri <git service user> <git service repo> <version> -g <git service domain (github.com)>
# eg
gri barthr redo 0.3.0 $HOME/Downloads -a Linux_X86_64

```

### Do not extract

```bash
gri <github user> <github repo> <version> --no-extract

```

### Do not add execution right

```bash
gri <github user> <github repo> <version> --no-exec

```

### Download source

implies --no-exec

```bash
gri <github user> <github repo> <version> --source

```

### Download from http

```bash
gri <github user> <github repo> <version> --no-secure


```

## Developpement

As I'm using argbash to create the parsing of arguments there's a couple of difference with a standard shell script.

To edit the script edit the gri.m4 file.
Use the makefile to build the script

```bash
make build-script
# or build all artifact : doc, completion and script
make build
```

### Known issue

* missing ```[]``` for the if statement on line 2 after building script.
