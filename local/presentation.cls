% Custom beamer metropolis style file

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{presentation}[2020/07/27 Beamer Metropolis custom class]

%=====================================================================
%========================= required packages =========================
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass[10pt]{beamer}
\RequirePackage[english]{babel}
\RequirePackage{booktabs}
\RequirePackage{pgfplots}
\RequirePackage{xspace}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{url}
\RequirePackage{csquotes}
\RequirePackage{caption}

%=====================================================================
%========================= beamer metropolis =========================

% Beamer setup
\usetheme[progressbar=frametitle,
          sectionpage=progressbar,
          numbering=counter,
          titleformat=allsmallcaps,
          titleformat title=regular,
          titleformat subtitle=allsmallcaps,
          titleformat section=allsmallcaps,
          titleformat frame=allsmallcaps,
          block=fill]{metropolis}

% Define custom colors
\definecolor{palegrey}{HTML}{e0e0e0}
\definecolor{palegreybg}{HTML}{efefef}
\definecolor{darkgrey}{HTML}{404040}
\definecolor{blackestblack}{HTML}{000000}
\definecolor{whitestwhite}{HTML}{ffffff}

% These are the default colors for Metropolis from Tol Colors
\definecolor{mDarkBrown}{HTML}{604c38}
\definecolor{mDarkTeal}{HTML}{23373b}
\definecolor{mLightBrown}{HTML}{EB811B}
\definecolor{mLightGreen}{HTML}{14B03D}

% Tol colors
\definecolor{TolDarkPurple}{HTML}{332288}
\definecolor{TolDarkBlue}{HTML}{6699CC}
\definecolor{TolLightBlue}{HTML}{88CCEE}
\definecolor{TolLightGreen}{HTML}{44AA99}
\definecolor{TolDarkGreen}{HTML}{117733}
\definecolor{TolDarkBrown}{HTML}{999933}
\definecolor{TolLightBrown}{HTML}{DDCC77}
\definecolor{TolDarkRed}{HTML}{661100}
\definecolor{TolLightRed}{HTML}{CC6677}
\definecolor{TolLightPink}{HTML}{AA4466}
\definecolor{TolDarkPink}{HTML}{882255}
\definecolor{TolLightPurple}{HTML}{AA4499}

% venkatasg.me colors
\definecolor{GitHubBlue}{HTML}{79B8FF}
\definecolor{GitHubDBlue}{HTML}{0366D6}

% Font setup
\RequirePackage{unicode-math}
\setmainfont{Equity A}
\newfontfamily{\sansc}{Concourse 3 Caps}[Letters=UppercaseSmallCaps]
\newfontfamily{\rmsc}{Equity A Caps}[Letters=UppercaseSmallCaps]
\newfontfamily{\sancs}{Concourse 3 Caps}
\newfontfamily{\rmcs}{Equity A Caps}
\newfontfamily{\nfwc}{Concourse T3 Index}
\newfontfamily{\nfws}{Concourse T3 Index}[StylisticSet = 1]
\newfontfamily{\nfbc}{Concourse T3 Index}[StylisticSet = 2]
\newfontfamily{\nfbs}{Concourse T3 Index}[StylisticSet = 3]
\setmonofont{Source Code Pro}[Scale=MatchLowercase]
\setmathfont{Asana Math}[Scale=MatchLowercase]


%Now choose between dark and light themes, dark themes need a very thin font for contrast between regular text and bold font, but not so for the light theme

\DeclareOption{light} {
    \colorlet{fgcolor}{darkgrey}
    \colorlet{bgcolor}{palegreybg}
    \colorlet{bluelinkcolor}{GitHubDBlue}
    \setsansfont{Concourse 3}
    \newfontfamily{\headersansc}{Concourse 3 Caps}[Letters=UppercaseSmallCaps]
    }

\DeclareOption{white} {
    \colorlet{fgcolor}{darkgrey}
    \colorlet{bgcolor}{whitestwhite}
    \colorlet{bluelinkcolor}{GitHubDBlue}
    \setsansfont{Concourse 3}
    \newfontfamily{\headersansc}{Concourse 3 Caps}[Letters=UppercaseSmallCaps]
    }

\DeclareOption{maxcontrastwhite} {
    \colorlet{fgcolor}{blackestblack}
    \colorlet{bgcolor}{whitestwhite}
    \colorlet{bluelinkcolor}{GitHubDBlue}
    \setsansfont{Concourse 3}
    \newfontfamily{\headersansc}{Concourse 3 Caps}[Letters=UppercaseSmallCaps]
    }

\DeclareOption{dark} {
    \colorlet{fgcolor}{palegrey}
    \colorlet{bgcolor}{mDarkTeal}
    \colorlet{bluelinkcolor}{GitHubBlue}
    \setsansfont{Concourse 2}
    \newfontfamily{\headersansc}{Concourse 2 Caps}[Letters=UppercaseSmallCaps]
    }

\DeclareOption{black} {
    \colorlet{fgcolor}{palegrey}
    \colorlet{bgcolor}{blackestblack}
    \colorlet{bluelinkcolor}{GitHubBlue}
    \setsansfont{Concourse 2}
    \newfontfamily{\headersansc}{Concourse 2 Caps}[Letters=UppercaseSmallCaps]
    }

\DeclareOption{maxcontrastblack} {
    \colorlet{bgcolor}{blackestblack}
    \colorlet{fgcolor}{whitestwhite}
    \colorlet{bluelinkcolor}{GitHubDBlue}
    \setsansfont{Concourse 2}
    \newfontfamily{\headersansc}{Concourse 2 Caps}[Letters=UppercaseSmallCaps]
    }

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

\setbeamerfont{title}{series=\sffamily, size=\Large}
\setbeamerfont{subtitle}{series=\headersansc, size=\large}
\setbeamerfont{frametitle}{series=\headersansc, size=\Large}
\setbeamerfont{section title}{series=\headersansc, size=\LARGE}

% Dark mode
\setbeamercolor{normal text}{bg=bgcolor, fg=fgcolor}
\setbeamercolor{frametitle}{bg=bgcolor, fg=fgcolor}

% Line spacing
\linespread{1.2}

% Strong widow and orphan control

\clubpenalty10000
\widowpenalty10000

% French Spacing

\frenchspacing


% Link color setup
\hypersetup{
    colorlinks,breaklinks,
                linkcolor=fgcolor,
                urlcolor=bluelinkcolor,
                citecolor=fgcolor,
                filecolor=fgcolor
    }
\renewcommand*{\UrlFont}{\ttfamily}

%Bold and alert Text
\newcommand\alertb[1]{\textcolor{mLightBrown}{\textbf{#1}}}

%PGF grid style
\pgfplotsset{grid style={dashed,fgcolor}}
%=====================================================================
%=========================== bibliography ============================
% Citation stuff here
\RequirePackage[backend=biber,
                style=my-style,
                natbib,
                maxcitenames=1,
                maxbibnames=99]{biblatex}
\renewcommand*{\citesetup}{\tiny}
\renewcommand*{\bibfont}{\scriptsize}
\setbeamertemplate{bibliography item}{}


%=====================================================================
%=========================== useful macros ===========================

% Add footnote without a superscript
\newcommand\blfootnote[1]{%
  \begingroup
  \renewcommand\thefootnote{}\footnote{#1}%
  \addtocounter{footnote}{-1}%
  \endgroup
}

% Linguex stuff
\RequirePackage{linguex} % define here to avoid a clash
\renewcommand{\eachwordone}{\textsf}
\renewcommand{\eachwordtwo}{\textsf} % Makes glosses sans serif
\makeatletter   % used to reference previous examples
\newif\if@repeated\@repeatedfalse
\newcounter{savedExNo}
\renewcommand{\NormalEx}{\ifExWarning
     \PackageWarning{linguex}{Check example numbering (screwed up?),
     check number of empty lines at end of examples.
     Detected}\fi\ExWarningtrue
     \if@repeated
        \Exformat[\ref{\tmp@ref}]
        \setcounter{ExNo}{\value{savedExNo}}
        \global\@repeatedfalse
     \else
     \if@noftnote\refstepcounter{ExNo}%
        \Exformat[\ExLBr\Exarabic{ExNo}\ExRBr]%
     \else
         \refstepcounter{FnExNo}\Exformat[\FnExLBr\Exroman{FnExNo}\FnExRBr]%
     \fi
     \fi}
\newcommand{\exr}[1]{%
\@repeatedtrue
\setcounter{savedExNo}{\value{ExNo}}
\def\tmp@ref{#1}
\ex.}

% Change the numbering font for linguex examples
\renewcommand{\ExLBr}{\nfwc}
\renewcommand{\ExRBr}{\nfwc}

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