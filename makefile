# List of named documents to build. Add one for every seperate LaTeX document root
TARGETS := paper.pdf

# Specify LaTeX source directory & destination directory for compiled PDFs
SRC_DIR  = latex/
DEST_DIR = ./

# Autodiscover dependencies for target PDFs.
TEX_FILES := $(shell find $(SRC_DIR) -type f -name '*.tex')
CLS_FILES := $(shell find $(SRC_DIR) -type f -name '*.cls')
XMP_FILES := $(shell find $(SRC_DIR) -type f -name '*.xmpdata')
IMG_FILES := $(shell find $(SRC_DIR) -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' \))
DEPENDS   := $(TEX_FILES) $(CLS_FILES) $(XMP_FILES) $(IMG_FILES)

# Set creation & mod. date of PDF to epoch of latest git commit for reproducible builds.
COMMIT_EPOCH = $(shell git log -1 --pretty=%ct)

# Build all targets
all: $(TARGETS)

# For every PDF target, build it's corresponding TeX file with dependencies
%.pdf: $(addprefix $(SRC_DIR), %.tex) $(DEPENDS)
	SOURCE_DATE_EPOCH=$(COMMIT_EPOCH) latexmk -pdf -lualatex -silent -cd -use-make $<
	mv -u -v $(addprefix $(SRC_DIR), $@) $(DEST_DIR)$@
	sha256sum $(DEST_DIR)$@

# Delete LaTeX compilation auxiliary files.
clean: 
	latexmk -cd -quiet -c $(addprefix $(SRC_DIR), $(basename $(TARGETS)))

# Delete LaTeX compilation auxiliary files AND output PDFs (if they exist)
delete: clean
	@if [ -n "$(wildcard $(addprefix $(DEST_DIR), $(TARGETS)))" ]; then \
        rm -v $(addprefix $(DEST_DIR), $(TARGETS)); \
    fi