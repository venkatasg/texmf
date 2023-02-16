% My style file for one column reports and papers by Venkat based on:
% Semantics & Pragmatics style file.
% Kai von Fintel, Christopher Potts, and Chung-chieh Shan

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{simple-report}[2020/07/24 v.1.0]

%====================================================================
%===================== release notes ================================

% 2020-07-24: v1.0, first draft

%======================= Outline ====================================
%====================================================================

% OUTLINE OF THIS CLASS FILE
%   option declarations
%   required packages
%   metadata
%   page dimensions
%   title
%   running headers
%   frontmatter
%   sectioning
%   footnotes
%   bibliography
%   backmatter
%   other environments
%   useful macros

%=====================================================================
%======================== option declarations ========================

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax
\LoadClass[11pt,oneside]{article}

% amsmath must be loaded before unicode-math; might as well load it here
\RequirePackage[leqno,tbtags]{amsmath}

% Left alignment
%\if@ragged2e
%    \RequirePackage[document]{ragged2e}
%\fi

% For quotes
\RequirePackage{csquotes}

% Set main serif fonts
\RequirePackage{unicode-math}
\setmainfont{Equity A}[Numbers={Lowercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
\newfontfamily{\rmsc}{Equity A Caps}[Letters=UppercaseSmallCaps, Numbers={Uppercase,Proportional}]
\newfontfamily{\rmcs}{Equity A Caps}[Numbers={Uppercase,Proportional}]

% Oldstyle tabular numbers inside tabular environment
\newcommand\lining{\addfontfeatures{Numbers={Uppercase, Monospaced}}\footnotesize}
\AtBeginEnvironment{tabular}{\lining}
\renewcommand{\theequation}{ {\lining\arabic{equation}}}

% Set main sans-serif fonts
\setsansfont{Concourse 3}
\newfontfamily{\sansc}{Concourse 3 Caps}[Letters=UppercaseSmallCaps, Letters=UppercaseSmallCaps]
\newfontfamily{\sancs}{Concourse 3 Caps}

% IPA, monospace, emoji and math fonts
\newfontfamily{\ipa}{Charis SIL}
\setmonofont{Triplicate A Code}[Scale=MatchLowercase]
\setmathfont{Asana Math}[Scale=MatchLowercase]

% Set linespacing to 1.1 times the point size
\RequirePackage{setspace}
\setstretch{1.1}

% Strong widow and orphan control
\clubpenalty10000
\widowpenalty10000

% French Spacing - single spacing between sentences
\frenchspacing

%=====================================================================
%========================= required packages =========================

\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{booktabs}
\RequirePackage{xspace}
% microtype handles punctuation at the right margin. We want it for
% the final product, but it's okay if authors lack it.
\IfFileExists{microtype.sty}{%
  \RequirePackage[final,protrusion={true,compatibility}, expansion=true]{microtype}
}{}
\RequirePackage[hyphens]{url}

% Uses my custim my-style bib format based on unified
% if neither style can be found, fallback to BibTeX.
\IfFileExists{my-style.bbx}
    {\RequirePackage[backend=biber,
                    style=my-style,
                    natbib,
                    maxcitenames=1,
                    maxbibnames=99]{biblatex}}
    {}

%=====================================================================
%======================== Color & Hyperlinks =========================
\RequirePackage[usenames,dvipsnames,table]{xcolor}

% Tol colors
\definecolor{TolIndigo}{HTML}{332288}
\definecolor{TolCyan}{HTML}{88CCEE}
\definecolor{TolTeal}{HTML}{44AA99}
\definecolor{TolGreen}{HTML}{117733}
\definecolor{TolOlive}{HTML}{999933}
\definecolor{TolSand}{HTML}{DDCC77}
\definecolor{TolRose}{HTML}{CC6677}
\definecolor{TolWine}{HTML}{882255}
\definecolor{TolPurple}{HTML}{AA4499}
\definecolor{TolPaleGrey}{HTML}{DDDDDD}

\definecolor{bluelinkcolor}{HTML}{0366D6}
\definecolor{graylinkcolor}{HTML}{404040}
\definecolor{redalertcolor}{RGB}{215,58,73}
\RequirePackage[colorlinks,breaklinks,
                linkcolor=black,
                urlcolor=bluelinkcolor,
                citecolor=bluelinkcolor,
                filecolor=graylinkcolor,
                plainpages=false,
                pdfpagelabels,
                bookmarks=false,
                pdfstartview=FitH]{hyperref}
\newcommand{\doi}[1]{\url{https://doi.org/#1}}

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
%========================== page dimensions ==========================

\RequirePackage{geometry}
\newlength{\alphabet}
\settowidth{\alphabet}{\normalfont abcdefghijklmnopqrstuvwxyz}
\geometry{paper=a4paper, top=1in, bottom=1in, textwidth=2.5\alphabet, includefoot}

%=====================================================================
%============================== title ================================

% Formats individual <name--institute> pairs inside \author.
\newcommand{\repauthor}[1]{%
  \begin{minipage}[t]{16pc}\raggedright #1 \end{minipage}\hspace{.5pc plus1pc}%
  \ignorespaces
}

\renewcommand*{\title}[2][]{\gdef\@shorttitle{#1}\gdef\@title{#2}}
\renewcommand*{\author}[2][]{\gdef\@shortauthor{#1}\gdef\@author{#2}}

% Adapted from JMLR.
\renewcommand{\maketitle}{%
  \par
  \begingroup
  \renewcommand{\thefootnote}{\fnsymbol{footnote}}
  \@maketitle\@thanks
  \setcounter{footnote}{0}
  \endgroup
  \let\maketitle\relax \let\@maketitle\relax
  \gdef\@thanks{}
  \let\thanks\relax%
}

% From salt.cls.
\newskip\onelineskip
\onelineskip=\baselineskip
\advance\onelineskip by0pt plus 4pt minus 2pt

\def\@maketitle{%
   \vbox{
        \def\institute{}
        \def\course{\rmsc}
        \newcommand{\AND}{\ignorespaces}
        \hsize\textwidth
        \linewidth\hsize
        \raggedright
        \vskip\onelineskip
        \Large\textbf{\@title}\@@par
        \normalsize
        \let\par\@empty
        \rmfamily\@author
        \lineskiplimit\onelineskip
        \lineskip\onelineskip
        \@@par
   }%
   \global\everypar{\everypar{}\vskip 3.5ex}
}

%=====================================================================
%========================= header and footer =========================

% Prints page number at footer in sans foot with
\def\ps@simplepage{
  \def\@oddhead{}
  \def\@evenhead{}
  \def\@foot{\footnotesize\hfill\sansc\thepage\hfill}
}

\pagestyle{simplepage}

%=====================================================================
%============================ sectioning =============================

\RequirePackage[compact]{titlesec}
\titleformat{\section}{\large\bfseries}{\thesection}{1em}{}
%% Upright (normal) numbers here
\titleformat{\subsection}{\large\bfseries}{\thesubsection}{.6em}{}
%% Below, both heading should form sentences
\titleformat{\subsubsection}{\bfseries}{\thesubsubsection}{.6em}{}{\itshape}
\titleformat{\paragraph}[runin]{\bfseries}{\theparagraph}{0pt}{}

\titlespacing*{\section}{0pt}{2\baselineskip}{1\baselineskip}
\titlespacing*{\subsection}{0pt}{1\baselineskip}{1\baselineskip}
\titlespacing*{\subsubsection}{0pt}{8pt}{5pt}

%=====================================================================
%============================ footnotes ==============================

\renewcommand{\@makefntext}[1]{%
  \parindent=0.25in
  \noindent \hbox to \z@{\hss{\textsuperscript{\@thefnmark}} \hfil}#1}

%=====================================================================
%======================== other environments =========================

% enumerate labeling that won't conflict with standard ex. numbers.
\renewcommand{\theenumi}{\roman{enumi}}
\renewcommand{\labelenumi}{\theenumi.}
\renewcommand{\theenumii}{\alph{enumii}}
\renewcommand{\labelenumii}{\theenumii.}
  
%% Modify caption labels
\RequirePackage{caption}
\DeclareCaptionLabelFormat{lc}{\rmsc{#1}~{#2}}
\captionsetup{font=small, format=plain, labelformat=lc}
\captionsetup[subfigure]{labelsep=colon, labelfont=sc, labelformat=simple}
  
%% Modify list
\RequirePackage{enumitem}
\setlist{noitemsep}
\setlist{nosep}
\setlist[1]{labelindent=\parindent} % < Usually a good idea
%% Have to remove the bold and indent labels at the edge, text will still be
%% aligned at \parindent
\setlist[description]{font=\normalfont\rmsc, labelindent=0pt}

%=====================================================================
%=========================== useful macros ===========================

\def\co{\colon\thinspace}

\DeclareRobustCommand\dash{%
  \unskip\nobreak\thinspace\textemdash\thinspace\ignorespaces}
\pdfstringdefDisableCommands{\renewcommand{\dash}{ - }}

% based on \url defined in hyperref.sty
\DeclareRobustCommand*{\http}{\hyper@normalise\http@}
\def\http@#1{\hyper@linkurl{\Hurl{#1}}{http://#1}}

\newcommand{\email}[1]{\href{mailto:#1}{\ttfamily #1}}

\newcommand\blfootnote[1]{%
  \begingroup
  \renewcommand\thefootnote{}\footnote{#1}%
  \addtocounter{footnote}{-1}%
  \endgroup
}

\providecommand{\sv}[1]{\ensuremath{\llbracket{#1}\rrbracket}}

%=====================================================================
%=========================== linguex settings ========================

\RequirePackage{linguex}%
\renewcommand{\firstrefdash}{}%
\AtBeginDocument{\settowidth{\Exlabelwidth}{(110)}}

%================================ fin ================================
%=====================================================================
