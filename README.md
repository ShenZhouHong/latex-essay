# Shen's LaTeX Essay Template
This is my LaTeX Essay Template. It is a best-in-class LuaLaTeX template for writing essays, dissertations, documents, and papers in the academic humanities.

## Features
This template uses a number of advanced LaTeX features.

* Complete **PDF/A-3u Compatibility**, for Archival Grade Documents.
* **Fully Reproducible Builds** for PDF Compilation, using Makefile.
* **Custom Microtype Protrusion** Settings for Hanging Punctuation.
* **Typography Tweaks**, Adjustments, and Custom Headers and Footers.
* **BibLaTeX Integration** for Citation Management

## Quickstart
This git repository is set as a template. Simply clone the template, and begin. The root document is located at `./latex/paper.tex`. The `documentclass`, `\Title`, `\Author`, and `\Date` fields can be modified there.


To compile the document, simply enter the `latex` directory, and run `make`:

```
cd latex
make
```

## Documentation
This template is broadly organized into three directories. `template` contains template files. `sections` contain the body of the text. `figures` contains figures, diagrams, and graphs. 

```
.
├── example.png
├── latex
│   ├── citations.bib
│   ├── configuration.tex
│   ├── figures
│   │   ├── template-*.tex
│   │   └── ...
│   ├── makefile
│   ├── paper.pdf
│   ├── paper.tex
│   ├── paper.xmpdata
│   ├── sections
│   │   ├── body.tex
│   │   └── endpage.tex
│   └── template
│       ├── formatting.tex
│       └── packages.tex
├── LICENSE.md
└── README.md

```

The body of the text is meant to be included in the `./latex/sections` directory. Begin writing in `./latex/sections/body.tex`, and add additional sections within that directory (e.g. `./latex/sections/introduction.tex`).

Metadata for the PDF must be configured in the `./latex/paper.xmpdata` file. This file is read by the `pdfx` package, and information within is used to generate a valid, standard-conformant PDF/A-3u document.

The header, footer, and additional packages can be configured in `./latex/configurations.tex`. Biblatex, as well as a set of commonly used packages for mathematics and sciences are included as comments.

All the template files are located within the `./latex/template` directory. `packages.tex` defines the load order of packages included in the document's preamble. User-configured packages from `configurations.tex` are `\input`-ed into the middle of `packages.tex`, in order to preserve the load-order of packages.

Template configuration (typography, sections, and hyperlink setup) are located within `./latex/template/formatting.tex`. The options here are not expected to be modified.

Citations for `biblatex` can be added in `./latex/citations.bib`. The biblatex package can be enabled by uncommenting the relevant package includes in `./latex/configurations.tex`. An example bibliography is also available as a comment in `./latex/sections/endpage.tex`.

## Dependencies
This template depends on the following programs:

* GNU Make: Used for the makefile for compiling the PDF document
* Latexmk: Tool used with Make to run LaTeX for the correct number of runs.
* LuaLaTeX: The default typesetting engine used.
* Microtype version >= `3.0`. This template uses advanced protrusion features only available in recent versions of microtype.

## Related documentation
For an overview of how to populate biblatex `citations.bib` files, visit the
biblatex-mla manual at CTAN.

* https://www.ctan.org/pkg/biblatex-mla

## GPLv3 License
The raw template itself is licensed under the terms of the GPL (version 3). A
full copy of the license is attached in `LICENSE.md`. Naturally, any works
that you create using this template (i.e. any actual essays you write using
it) will be your own intellectual property.