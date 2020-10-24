% My style file for reports and papers by Venkat based on:
% Semantics & Pragmatics style file.
% Kai von Fintel, Christopher Potts, and Chung-chieh Shan

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{report}[2020/07/24 v.1.0]

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

% font selection
\newcount\@fontenum
% example-numbering packages
\newif\if@expex
\newif\if@linguex
% production settings
\newif\if@biblatex

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% example-numbering packages
\DeclareOption{expex}{\@expextrue}
\DeclareOption{linguex}{\@linguextrue}
% production settings
\DeclareOption{biblatex}{\@biblatextrue}

\ProcessOptions\relax
\LoadClass[11pt,twoside]{article}

% amsmath must be loaded before unicode-math; might as well load it here
\RequirePackage[leqno,tbtags]{amsmath}

% Load custom fonts
\RequirePackage{unicode-math}
\setmainfont{Equity Text A}
\setsansfont{Concourse T3}
\newfontfamily{\sansc}{Concourse C3}[Letters=UppercaseSmallCaps]
\newfontfamily{\rmsc}{Equity Caps A}[Letters=UppercaseSmallCaps]
\newfontfamily{\sancs}{Concourse C3}
\newfontfamily{\rmcs}{Equity Caps A}
\newfontfamily{\nfwc}{Concourse T3 Index}
\newfontfamily{\nfws}{Concourse T3 Index}[StylisticSet = 1]
\newfontfamily{\nfbc}{Concourse T3 Index}[StylisticSet = 2]
\newfontfamily{\nfbs}{Concourse T3 Index}[StylisticSet = 3]
\newfontfamily{\ipa}{Charis SIL}
\setmonofont{Monaco}[Scale=MatchLowercase]
\setmathfont{Asana Math}[Scale=MatchLowercase]

\linespread{1.2}

% Strong widow and orphan control

\clubpenalty10000
\widowpenalty10000

% French Spacing

\frenchspacing

%=====================================================================
%========================= required packages =========================


\RequirePackage{xspace}
% microtype handles punctuation at the right margin. We want it for
% the final product, but it's okay if authors lack it.
\IfFileExists{microtype.sty}{%
  \RequirePackage[final,protrusion={true,compatibility}]{microtype}
}{}
\RequirePackage[hyphens]{url}

% Uses my custim my-style bib format based on unified
% if neither style can be found, fallback to BibTeX.
\if@biblatex
  \IfFileExists{my-style.bbx}
    {\RequirePackage[backend=biber,
                    style=my-style,
                    natbib,
                    maxcitenames=3,
                    maxbibnames=99]{biblatex}}
    {}
\fi

\RequirePackage[usenames,dvipsnames,table]{xcolor}
\definecolor{bluelinkcolor}{HTML}{0366D6}
\definecolor{graylinkcolor}{HTML}{404040}
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
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage[hang,FIGBOTCAP,loose]{subfigure}
\RequirePackage{booktabs}

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

% Vertical.
\paperheight=11in
\topmargin=0in     %
\headheight=0.2in  % head: 1.5in (margin + head + sep = .5; latex adds 1in)
\headsep=0.3in     %
\topskip=0.1in     % included in the textheight
\textheight=8in    % text is 8in
\footskip=0.5in    % foot: 1.5in (.5 + 1.0in leftover)
\parskip=0pt

% Horizontal.
\paperwidth=8.5in
\textwidth=5.0in
\oddsidemargin=0.5in  % 1.5in due to LaTeX's calculations
\evensidemargin=0.5in % 1.5in due to LaTeX's calculations
\raggedbottom % constant spacing in the text; cost is a ragged bottom
\parindent=0.25in
\leftmargini=0.5in
\@ifundefined{mathindent}{}{\mathindent=0.5in\relax}%

% Tell dvips about our paper.
\special{papersize=8.5in,11in}

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
        \Large\rmfamily\textbf{\@title}\@@par
        \normalsize
        \let\par\@empty
        \@author
        \lineskiplimit\onelineskip
        \lineskip\onelineskip
        \@@par
   }%
   \global\everypar{\everypar{}\vskip 3.5ex}
}

%=====================================================================
%========================== running headers ==========================
% \RequirePackage{fancyhdr}
% Prints publication and copyright info on the first page
\def\ps@firstpage{
  \def\@oddhead{}
  \def\@evenhead{}
  \def\@foot{\footnotesize\hfill\sansc\thepage\hfill}
}

% Prints abbreviated article information on non-initial pages.
\def\ps@newheadings{
  \let\@mkboth\@gobbletwo
  % short title on inner (left) side
  \def\@oddhead{\footnotesize\sansc\@shorttitle\hfill}
  % author name(s) on inner (right) side
  \def\@evenhead{\footnotesize\hfill\sansc\@shortauthor}
  % centered page number (with article prefix if available) on all pages
  \def\@oddfoot{\footnotesize\hfill\sansc\thepage\hfill}
  \let\@evenfoot\@oddfoot
}

% set spheadings as default pagestyle throughout document
\pagestyle{newheadings}
\thispagestyle{firstpage}

%=====================================================================
%=========================== frontmatter =============================

% The spacing specs (arg 2 of \list) are the same for the mshistory,
% abstract, and keywords environments, except that the abstract is
% indented somewhat.

% Single parameter determines the left and right margin size.
\newcommand{\frontmatterspacing}[1]{%
  \small
  \topsep 10\p@ \@plus4\p@   \@minus6\p@ % from size12.clo
  \advance\topsep by3.5ex plus -1ex minus -.2ex
  \setlength{\listparindent}{0em}
  \setlength{\itemindent}{0em}
  \setlength{\leftmargin}{#1}
  \setlength{\rightmargin}{\leftmargin}
  \setlength{\parskip}{0em}
}

\newenvironment{mshistory}%
{\list{}{\frontmatterspacing{0em}}%
\item\relax}%
{\endlist}

% \ignorespacesandpars inspired by http://tex.stackexchange.com/a/179034/3642
\def\ignorespacesandpars{%
  \@ifnextchar\par{\expandafter\ignorespacesandpars\@gobble}{\ignorespaces}}

\renewenvironment{abstract}%
{\list{}{\frontmatterspacing{0.25in}}%
\item\relax\textbf{\abstractname}~~\ignorespacesandpars}%
{\endlist}

\newenvironment{keywords}%
{\list{}{\frontmatterspacing{0em}}%
\item\relax\textbf{Keywords:}}%
{\endlist}

%=====================================================================
%============================ sectioning =============================

\renewcommand{\section}{\@startsection{section}{1}{\z@}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\large\bfseries\rmsc}}

\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\large\bfseries\rmsc}}

\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\large\bfseries\rmsc}}

\renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
  {3.5ex plus 1ex minus .2ex}%
  {-1em plus0.0ex}%
  {\noindent\normalsize\bfseries}}

\renewcommand{\subparagraph}{\@startsection{subparagraph}{5}{\z@}%
  {3.5ex plus 1ex minus .2ex}%
  {-1em plus0.0ex}%
  {\noindent\normalsize\it}}

% General formatting --- for punctuating section headings.
\renewcommand{\@seccntformat}[1]{\small \rmsc \@nameuse{the#1}\hspace{1em}}

%=====================================================================
%============================ footnotes ==============================

\renewcommand{\@makefntext}[1]{%
  \parindent=0.25in
  \noindent \hbox to \z@{\hss{\@thefnmark} \hfil}#1}

%=====================================================================
%============================ backmatter =============================

% Environment for formatting all the addresses.
\newenvironment{addresses}%
 {\@@par\let\par\@empty\addvspace{3.25ex}\small\ignorespaces}%
 {\lineskiplimit 1pc\lineskip 1pc\@@par}
% Sub-environment for formatting each individual author's address.
\newenvironment{address}[1][.5\textwidth]%
 {\noindent\ignorespaces\begin{minipage}[t]{#1}\raggedright}%
 {\end{minipage}\allowbreak\ignorespacesafterend}

%=====================================================================
%======================== other environments =========================

% enumerate labeling that won't conflict with standard ex. numbers.
\renewcommand{\theenumi}{\roman{enumi}}
\renewcommand{\labelenumi}{\theenumi.}
\renewcommand{\theenumii}{\alph{enumii}}
\renewcommand{\labelenumii}{\theenumii.}

% list spacing ought to satisfy \itemsep + \parsep < \topsep + \parskip
\def\@listi{\leftmargin\leftmargini
            \parsep 4\p@  \@plus2\p@ \@minus\p@
            \topsep 10\p@ \@plus4\p@ \@minus\p@
            \itemsep4\p@  \@plus2\p@ \@minus\p@}
\let\@listI\@listi
\@listi

% typeset figures with lines above and below and the caption title and
% caption texts in boxes next to each other, top aligned.  these
% definitions extend those of float.sty.
%
% sp caption style
\newlength\floatc@sp@contentwidth
\newcommand\floatc@sp[2]{%
  \setlength\floatc@sp@contentwidth{\linewidth}%
  \addtolength\floatc@sp@contentwidth{-60pt}%
  \parbox[t]{60pt}{{\@fs@cfont#1}}%
  \parbox[t]{\floatc@sp@contentwidth}{#2}}%

% sp float style; uses the sp caption style
\newcommand\fs@sp{
  \def\@fs@cfont{\bfseries\rmsc}\let\@fs@capt\floatc@sp
  \def\@fs@pre{\hrule\kern5pt}%
  \def\@fs@post{\kern5pt\hrule\relax}%
  \def\@fs@mid{\kern10pt}
  \let\@fs@iftopcapt\iffalse}

% users can override these commands using float.sty's functionality
\floatstyle{sp}
\restylefloat{figure}
\restylefloat{table}

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

\if@linguex
  \RequirePackage{linguex}%
  \renewcommand{\firstrefdash}{}%
  \AtBeginDocument{\settowidth{\Exlabelwidth}{(110)}}
\fi

%=====================================================================
%=========================== expex settings ========================

\if@expex
  \RequirePackage{expex}%
  \lingset{%
    exskip=-0.5ex,
    interpartskip=0.5ex,
    aboveexskip=1ex,
    belowexskip=2ex,
    everygla=}
  \def\everyfootnote{%
    \keepexcntlocal
    \excnt=1
    % exskip: sets aboveexskip and belowexskip at the same time
    % exnotype: sets the family for root example numbering (default: arabic)
    %           (must be one of: arabic, chapter.arabic, or roman)
    % sampleexno: sets root example to constant width (default: no constant width)
    % labeltype: sets the family for subexample numbering (default: alpha)
    % labelanchor: sets left alignment of subexample (default: numright)
    % labeloffset: left margin of subexample numbering (default: 1em)
    % textoffset: distance between subexample numbering and text (default: 1em)
    \lingset{exskip=1ex,exnotype=roman,labeloffset=.6em,textoffset=.6em}
  }
  \renewcommand{\@makefntext}[1]{%
    \everyfootnote
    \parindent=0.25in
    \noindent \hbox to \z@{\hss{\@thefnmark} \hfil}#1%
  }
  \gathertags
\fi

%================================ fin ================================
%=====================================================================