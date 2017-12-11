# Basic LaTeX Essay Template

## Quickstart
In order to customize this LaTeX template file to your project, simply rename
the `essay-name.tex` file, and than edit the the included makefile to point at
the right file again:

### makefile

```
# Makefile for latexmk
source_name = essay-name

...
```

### Compiling document

In order to compile latex source files, run `make` in the terminal:

```
cd latex
make
make clean
```
