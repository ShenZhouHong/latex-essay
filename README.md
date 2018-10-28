# Basic LaTeX Essay Template
This is an LaTeX essay template that's fairly useful for writing essays in the
humanities (i.e. philosophy, history). It's configured to use biblatex for
citation management, and outputs citations (as well as inline citations) in the
MLA format.

It is designed to be modular, with the mains scaffold of the template located at
`latex/essay-name.tex`, which falls in additional includes at `latex/includes`,
and content at `latex/sections`. This way, when working on relatively longer
essays, one can have all the textual content organized as multiple files in the
`latex/sections` folder, and have any custom formatting applied through the
`latex/includes` folder.

Additionally, the base folder of the repository is designed to be a good place
for sources, notes, as well as other secondary information used in the essay
writing process. This way, these files can be tracked into version-control as
well.

## Quickstart
In order to customize this LaTeX template file to your project, simply rename
the `essay-name.tex` file, and than edit the the included makefile to point at
the right file again:

### makefile
```
# Makefile for latexmk
source_name = essay-name
```
### Compiling document
In order to compile latex source files, run `make` in the terminal:
```
cd latex
make
make clean
```

Note: for any partial compiles where compilation fails at a certain point, you
should run `make clean` followed by make again. Trying to run make after a
failed compile would result in additional errors.

### Related documentation
For an overview of how to populate biblatex `citations.bib` files, visit the
biblatex-mla manual at CTAN.

* https://www.ctan.org/pkg/biblatex-mla
