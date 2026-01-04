% Style file for one column research/project reports

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{practical-report}[2023/07/18 v.1.0]

%====================================================================
%===================== release notes ================================

% 2023-07-18: v1.0

%======================= Outline ====================================
%====================================================================

% OUTLINE OF THIS CLASS FILE
%   option declarations
%   required packages
%   bibliography, links and color
%   metadata
%   page dimensions
%   title
%   sectioning
%   footnotes
%   other environments

%===============================================================================
%============================== option declarations ============================

% biblatex option
\newif\if@biblatex
\DeclareOption{biblatex}{\@biblatextrue}

% linguex option
\newif\if@linguex
\DeclareOption{linguex}{\@linguextrue}

% 1 inch margins all side option
\newif\if@inch
\DeclareOption{inch}{\@inchtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt,oneside]{article}

%===============================================================================
%=================================== page setup ================================

\RequirePackage{geometry}
 % Set textwidth to 2.5 times length of alphabet approx. 77 characters
\newlength{\alphabet}
\settowidth{\alphabet}{\normalfont abcdefghijklmnopqrstuvwxyz}

\if@inch
    \geometry{top=1in, bottom=1in, left=1in, right=1in}
\else
    \geometry{top=1in, bottom=1.25in, textwidth=2.7\alphabet}
\fi
%===============================================================================
%============================== required packages ==============================

% For quotes
\RequirePackage{csquotes}

% Loading figures
\RequirePackage{graphicx}

% Align tables and figures
\RequirePackage{float}

% Pretty tables
\RequirePackage{booktabs}

% Removes indentation at beginning of paragraphs. Space between paragraphs is 80% of font size, and at least 50% point size at end of paragraph
\RequirePackage[skip=0.8em, parfill=0.5em]{parskip}

% microtype handles punctuation at the right margin.
\RequirePackage[final,protrusion={true,compatibility}, expansion=true]{microtype}

%===============================================================================
%================================== typography =================================

% Left alignment
\RequirePackage[document]{ragged2e}

% amsmath must be loaded before unicode-math
\RequirePackage[leqno,tbtags]{amsmath}
\RequirePackage{unicode-math}

% Set main serif fonts
\setmainfont[Numbers={Lowercase,Proportional}, Contextuals=Alternate]{Equity A}
\newcommand\liningfont{\addfontfeatures{Numbers={Uppercase, Proportional}}}
\newfontfamily{\rmsc}{Equity A Caps}[Letters=UppercaseSmallCaps, LetterSpace=5, Numbers={Lowercase,Proportional}]
\newfontfamily{\rmcs}{Equity A Caps}[Letters=Uppercase, LetterSpace=5, Numbers={Uppercase,Proportional}]

% IPA, monospace, and math fonts
\newfontfamily{\ipa}{Charis SIL}
\setmonofont[Scale=MatchLowercase]{Triplicate A Code}
\setmathfont[Path=/Users/venkat/Library/Fonts/, Extension=.otf, Ligatures=TeX, BoldFont=XCharter-Math-Bold, ItalicFont=XCharter-Italic]{XCharter-Math}

% Oldstyle tabular numbers inside tabular environment
\AtBeginEnvironment{tabular}{\addfontfeatures{Numbers={Uppercase, Monospaced}}}
\AtBeginEnvironment{tikzpicture}{\addfontfeatures{Numbers={Uppercase, Monospaced}}}
\renewcommand{\theequation}{ {\addfontfeatures{Numbers={Uppercase, Monospaced}}\arabic{equation}}}

% Set linespacing to 1.1 times the point size, this sets baseline skip to almost exactly 136% which is what Matthew Butterick used in his example
\RequirePackage{setspace}
\setstretch{1.1}

% Strong widow and orphan control - avoid any widows and orphans
\clubpenalty10000
\widowpenalty10000

% French Spacing - single spacing between sentences
\frenchspacing

%===============================================================================
%============================= Bibliography ====================================

% Handles line breaks within urls
\RequirePackage[hyphens]{url}
\def\UrlFont{\tt}

% Bibliography settings
\if@biblatex
    \RequirePackage[backend=biber,
                    style=numeric,
                    natbib,
                    maxcitenames=1,
                	maxbibnames=999,
                	sorting=none,
                	url=false,
                	doi=false,
                	eprint=false]{biblatex}
    \setlength\bibitemsep{0.5\baselineskip}
    \addbibresource{references.bib}
\fi

%===============================================================================
%=========================== Color & links =====================================
% color
\RequirePackage[table]{xcolor}

% Custom Red
\definecolor{MokaRed}{HTML}{A52A2A}

% Custom Blue
\definecolor{AmmaBlue}{HTML}{0366D6}

% Hyperref setup
\RequirePackage{hyperref}
\hypersetup{
    colorlinks,
    breaklinks,
    linkcolor=black,
    urlcolor=AmmaBlue,
    citecolor=AmmaBlue,
    filecolor=AmmaBlue,
    plainpages=false,
    pdfstartview=FitH,
}

%=====================================================================
%============================= metadata ==============================

\def\@pdfauthor{\relax}
\newcommand{\pdfauthor}[1]{\gdef\@pdfauthor{#1}}
\def\@pdftitle{\relax}
\newcommand{\pdftitle}[1]{\gdef\@pdftitle{#1}}
\def\@pdfkeywords{\relax}
\newcommand{\pdfkeywords}[1]{\gdef\@pdfkeywords{#1}}

\hypersetup{pdfauthor=\@pdfauthor,
            pdftitle=\@pdftitle,
            pdfkeywords=\@pdfkeywords}

%=====================================================================
%============================== title ================================

\renewcommand*{\title}[2][]{\gdef\@alttitle{#1}\gdef\@title{#2}}
\renewcommand*{\author}[1]{\gdef\@author{#1}}

\def\@maketitle{%
   \vbox{
        \parskip=0.1\baselineskip
        \liningfont
        \raggedright
        {\LARGE\bfseries\@title}
        \vskip0.5\baselineskip
        \@author\@@par
        \@alttitle\@@par
        \@date
        \vskip0.5\baselineskip
   }
}

%=====================================================================
%============================ sectioning =============================

\RequirePackage[compact]{titlesec}

\titleformat{\section}{\Large\bfseries\liningfont}{\thesection}{1em}{}
\titleformat{\subsection}{\large\bfseries\liningfont}{\thesubsection}{.8em}{}
\titleformat{\subsubsection}{\normalsize\bfseries\rmsc}{\thesubsubsection}{.6em}{}{\itshape}
\titleformat{\paragraph}[runin]{\bfseries}{\liningfont\theparagraph}{0.6em}{\liningfont}

\titlespacing*{\section}{0pt}{\baselineskip}{\baselineskip}
\titlespacing*{\subsection}{0pt}{1\baselineskip}{1\baselineskip}
\titlespacing*{\subsubsection}{0pt}{0.8\baselineskip}{0.6\baselineskip}

%===============================================================================
%================================= footnotes ===================================

\renewcommand{\@makefntext}[1]{%
  \noindent \hbox to \z@{\hss{\textsuperscript{\@thefnmark}} \hfil}#1
}

%===============================================================================
%=================================== Captions ==================================

%% Modify caption labels
\RequirePackage{caption}
\DeclareCaptionLabelFormat{lc}{\rmsc{#1}~{#2}}
\captionsetup{format=plain, labelformat=lc, labelsep=quad, justification=centering}
\captionsetup[subfigure]{format=plain, labelformat=lc, labelsep=quad}

%===============================================================================
%=================================== useful macros =============================

\newcommand\blfootnote[1]{%
  \begingroup
  \renewcommand\thefootnote{}\footnote{#1}%
  \addtocounter{footnote}{-1}%
  \endgroup
}

\newcommand\alert[1]{\textcolor{MokaRed}{#1}}

%===============================================================================
%================================= list settings ===============================

%% Modify list spacing
\RequirePackage{enumitem}
\setlist{noitemsep}
\setlist{nosep}
\setlist{itemsep=0.25\baselineskip,topsep=0.25\baselineskip}

\setlist[1]{labelindent=\parindent} % < Usually a good idea
%% Have to remove the bold and indent labels at the edge, text will still be
%% aligned at \parindent
\setlist[description]{font=\normalfont\bfseries, labelindent=0pt}

\if@linguex
    \RequirePackage{linguex}%
    \renewcommand{\firstrefdash}{}
    
    % Spacing between subexamples
    \newlength{\SubItemSkip}
    \setlength{\SubItemSkip}{.5\baselineskip}
    \patchcmd{\a}{\itemsep\z@}{\itemsep\SubItemSkip}{}{}
    
    \AtBeginDocument{
    \setlength{\Exlabelsep}{1.5em}
    \setlength{\Extopsep}{.25\baselineskip}
    \setlength{\SubSubExleftmargin}{1.5em}
    \setlength{\SubExleftmargin}{1.5em}
    \setlength{\Exindent}{0pt}
    \setlength{\Exlabelwidth}{1em}
    }
\fi

%===============================================================================
%==================================== TOC ======================================

% Remove skip at beginning of TOC header since title already has baselineskip
\renewcommand\tableofcontents{
  \textbf{\Large\contentsname}\par
  \@starttoc{toc}%
}
