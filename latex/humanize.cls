% Humanize: An Opinionated LaTeX Template for the Humanities
\NeedsTeXFormat{LaTeX2e}[2021/11/15]
\ProvidesClass{humanize}[2021/11/15 v1.00 Humanize Custom LaTeX Report Class]

% Options made available used by \RequirePackage{setspace}
\DeclareOption{singlespacing}{%
  \AtEndOfClass{\singlespacing}
  \ClassInfo{humanize}{Line spacing set to 1.0}
}
\DeclareOption{onehalfspacing}{%
  \AtEndOfClass{\onehalfspacing}
  \ClassInfo{humanize}{Line spacing set to 1.5}
}
\DeclareOption{doublespacing}{%
  \AtEndOfClass{\doublespacing}
  \ClassInfo{humanize}{Line spacing set to 2.0}
}

% Options for left-margin protruded number labels
\DeclareOption{protrudelabels}{%
  \AtEndOfClass{
    % First, we implement protrusion for numerical section and subsection labels
    \newcommand{\marginsecnumber}[1]{%
      \makebox[0pt][r]{#1\hspace{6pt}}%
    }
    \titleformat{\section}
      {\normalfont\Large\bfseries}
      {\marginsecnumber\thesection}
      {0pt}
      {}
    \titleformat{\subsection}
      {\normalfont\large\bfseries}
      {\marginsecnumber\thesubsection}
      {0pt}
      {}
    \titleformat{\subsubsection}
      {\normalfont\normalsize\bfseries}
      {\marginsecnumber\thesubsubsection}
      {0pt}
      {}
    \titleformat{\paragraph}[runin]
      {\normalfont\normalsize\bfseries}
      {\marginsecnumber\theparagraph}
      {0pt}
      {}
    \titleformat{\subparagraph}[runin]
      {\normalfont\normalsize\bfseries}
      {\marginsecnumber\thesubparagraph}
      {0pt}
      {}
  }
  \AtBeginDocument{
    % Check first if biblatex is loaded with ieee-style citations
    \IfPackageLoadedWithOptionsTF{biblatex}{style=ieee}{%
      % If so, we define a new ieee bib environment style w/ protrusion
      \defbibenvironment{ieee-protrusion}
        {\list
          {\printtext[labelnumberwidth]{%
              \printfield{labelprefix}%
              \printfield{labelnumber}}}
          {\setlength{\labelwidth}{\labelnumberwidth}%
            % Where we set the \leftmargin length to minus \labelsep
            \setlength{\leftmargin}{-\labelsep}%
            \setlength{\labelsep}{\biblabelsep}%
            % And then add an additional 0.5em for alignment
            \addtolength{\leftmargin}{0.5em}%
            \setlength{\itemsep}{\bibitemsep}%
            \setlength{\parsep}{\bibparsep}}%
            \renewcommand*{\makelabel}[1]{\hss##1}}
        {\endlist}
        {\item}
      % Now we declare the default \printbibliography env to be ours
      \DeclarePrintbibliographyDefaults{
        env=ieee-protrusion,
      }
    }{}
  }
  \ClassInfo{humanize}{Label protrusions enabled}
}

% Next, we declare options for hanging punctuation.
\DeclareOption{hangingpunct}{%
  \AtEndOfClass{
    % This is done by passing a custom config file to microtype
    \LoadMicrotypeFile{protrusion}
    \ClassInfo{humanize}{Hanging punctuation enabled}
  }
}
\DeclareOption{nohangingpunct}{%
  \ClassInfo{humanize}{Hanging punctuation disabled}
}

% Options for additional decorative ligatures in libertinus-otf
\DeclareOption{extraligatures}{%
  \AtEndOfClass{
    \defaultfontfeatures+{
      % Options are: Common, Contextual, Rare, Historic, TeX
      Ligatures={Common, Discretionary, Historic}
    }
  }
  \ClassInfo{humanize}{Historical ligatures enabled}
}

% Option to enable/disable the geometry package's narrower margins
\DeclareOption{widemargins}{%
  \AtEndOfClass{
    \geometry{pass}
  }
  \ClassInfo{humanize}{Enabling geometry package's larger margins}
}

% Pass any other undeclared options to base article documentclass
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{report}
}

\AtBeginDocument{%
  % Check if biblatex is loaded.
  \IfPackageLoadedTF{biblatex}{
    % If so select \autocite from hyperref as cite command
    \SetCiteCommand{\autocite}
  }{}
  % Check if pgfplots package is loaded.
  \IfPackageLoadedTF{pgfplots}{
    % If so, disable legacy compatibility options and increase sample size
    \pgfplotsset{compat=1.18}
    \pgfplotsset{samples=300}
  }{}
}

% We first execute our default options. These can be overwritten by the user.
\ExecuteOptions{ 
  10pt,       % 10pt, 11pt, 12pt
  a4paper,    % a4paper, letterpaper, a5paper, b5paper, executivepaper, legalpaper
  final,      % draft
  onecolumn,  % twocolumn
  oneside,    % twoside
  notitlepage,% titlepage
  onehalfspacing,
  hangingpunct
}

% Now we process options belonging to the user
\ProcessOptions\relax

% First we load our base report class, as humanize is based upon report
\LoadClass{report}

% General packages in use
\RequirePackage{fontspec}                 % LuaLaTeX font support
\RequirePackage{babel}                    % Multiple languages and metadata support
\RequirePackage{libertinus-otf}           % Beautiful libertinus font
\RequirePackage{microtype}                % Microtypography adjustments
\RequirePackage{geometry}                 % Adjusts for narrower page margins
\RequirePackage[autopunct]{csquotes}      % For more advanced quotations
\RequirePackage{setspace}                 % Used to change line and paragraph spacing
\RequirePackage[indent=3em, skip]{parskip}% For empty lines between paragraphs
\RequirePackage[compact]{titlesec}        % Sets section titles to be more compact
\RequirePackage{titling}                  % In order to make the title higher on page
\RequirePackage{enumitem}                 % Customize itemize and enumerate environments


% Finally, we begin some misc. configuration

% Use fontspec to enable font features
\defaultfontfeatures+{
    Script=Latin,
    Language=Default,
    % Swash, Alternate, WordInitial, WordFinal, LineFinal, Inner
    Ligatures={Common, Discretionary},
    Contextuals={Alternate},
    Letters = Uppercase,
    RawFeature=+ccmp,
    Kerning = {On, Uppercase},
    Diacritics = {MarkToBase},
    UprightFeatures = {
      StylisticSet={2, 5, 6}
    }
}

\setmainfont{LibertinusSerif}

% Settings used by \usepackage{titling}
% The following command is used to "hang" the default LaTeX title from the top
% of the page (e.g. like a painting frame). The default LaTeX title sits a bit
% too low, so the following command sets it higher.
\setlength{\droptitle}{-2em}

% Settings for csquotes
\MakeOuterQuote{"}

% Set indentation for quotes to be at the same level as that of \parindent
\renewenvironment{quote}{%
  \small\list{}{\rightmargin=\parindent \leftmargin=\parindent}%
   \item\relax
}{%
  \endlist
}

% Likewise, set the indentation for itemize and enumerate to be at the same level as that of \parindent
\setlist[itemize,enumerate,description]{
  leftmargin=\dimexpr\parindent-\itemindent\relax,
  noitemsep % Reduces intra-item spacing in these environments 
}

% Some Final Late-Loading packages
\RequirePackage[a-3u, mathxmp]{pdfx}

% Settings used by \usepackage{hyperref}
\hypersetup{
  colorlinks=true,
  allcolors=blue,
  bookmarksopen=true
}
\urlstyle{sf}