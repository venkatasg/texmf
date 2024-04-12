% Custom beamer class file

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{practical-presentation}[2023/07/18 Beamer custom class]


%===============================================================================
%======================== option declarations ==================================

% biblatex option
\newif\if@biblatex

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}

% define biblatex option
\DeclareOption{biblatex}{\@biblatextrue}

\ProcessOptions\relax
\LoadClass{beamer}

%===============================================================================
%======================= base required packages ================================

\RequirePackage[english]{babel}
\RequirePackage{booktabs}
\RequirePackage{xspace}
\RequirePackage{setspace}
\RequirePackage{xcolor}
\RequirePackage{csquotes}
\RequirePackage{pgfplots}
\pgfplotsset{compat=newest}
\RequirePackage{appendixnumberbeamer}

%===============================================================================
%============================= metropolis theme ================================

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
\definecolor{palegreyfg}{HTML}{e9e9e9}
\definecolor{palegreybg}{HTML}{fcfcfc}
\definecolor{darkgreyfg}{HTML}{404040}
\definecolor{darkgreybg}{HTML}{222222}

% These are the default colors for Metropolis from Tol Colors
\definecolor{mDarkBrown}{HTML}{604c38}
\definecolor{mDarkTeal}{HTML}{23373b}
\definecolor{mLightBrown}{HTML}{EB811B}
\definecolor{mLightGreen}{HTML}{14B03D}

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


% My colors
\definecolor{AmmaBlue}{HTML}{0366D6}
\definecolor{MokaRed}{HTML}{D73A49}

% Set theme colors
\setbeamercolor{alerted text}{fg=MokaRed}
\setbeamercolor{progress bar}{fg=MokaRed}
\AtBeginEnvironment{frame}{
    \ifbeamer@plainframe
        \setbeamercolor{alerted text}{fg=MokaRed}
    \fi
}

% Set width of progress bar and separator
\setlength{\metropolis@titleseparator@linewidth}{1pt}
\setlength{\metropolis@progressonsectionpage@linewidth}{1pt}
\setlength{\metropolis@progressinheadfoot@linewidth}{1pt}

%===============================================================================
%================================== typography =================================

% Removes indentation at beginning of paragraphs
\RequirePackage{parskip}

% Left alignment
\RequirePackage[document]{ragged2e}

% amsmath must be loaded before unicode-math
\RequirePackage{amsmath}
\RequirePackage{unicode-math}


%Now choose between dark and light themes, dark themes need a very thin font for contrast between regular text and bold font, but not so for the light theme
\DeclareOption{light} {
    \colorlet{fgcolor}{darkgreyfg}
    \colorlet{bgcolor}{palegreybg}
    \setmainfont{Concourse 3}[Numbers={Uppercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
    \setsansfont{Concourse 3}[Numbers={Uppercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
    \newfontfamily{\sansc}{Concourse 3 Caps}[Letters=UppercaseSmallCaps, Numbers={Lowercase,Proportional}, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
    \newfontfamily{\sancs}{Concourse 3 Caps}[Letters=Uppercase, Numbers={Uppercase,Proportional}]
    }

\DeclareOption{dark} {
    \colorlet{fgcolor}{palegreyfg}
    \colorlet{bgcolor}{darkgreybg}
    \setmainfont{Concourse 2}[Numbers={Uppercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
    \setsansfont{Concourse 2}[Numbers={Uppercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
    \newfontfamily{\sansc}{Concourse 2 Caps}[Letters=UppercaseSmallCaps, Numbers={Lowercase,Proportional}, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
    \newfontfamily{\sancs}{Concourse 2 Caps}[Letters=Uppercase, Numbers={Uppercase,Proportional}]
    }

% IPA, monospace, serif and math fonts
\newfontfamily{\ipa}{Charis SIL}
\setmonofont[Scale=0.9]{Triplicate A Code}
\setfontfamily{\rmfamily}[Numbers={Lowercase,Proportional}, Contextuals=Alternate]{Equity A}
\newfontfamily{\rmsc}{Equity A Caps}[Letters=UppercaseSmallCaps, LetterSpace=5, Numbers={Lowercase,Proportional}]
\newfontfamily{\rmcs}{Equity A Caps}[Letters=Uppercase, LetterSpace=5, Numbers={Uppercase,Proportional}]
\setmathfont[Path=/Users/venkat/Library/Fonts/, Extension=.otf,Scale=MatchLowercase,Ligatures=TeX, Numbers={Uppercase,Monospaced}]{FiraMath-Regular}

% Fancy Numbering fonts
\newfontfamily{\nfwc}{Concourse T3 Index}
\newfontfamily{\nfbc}{Concourse T3 Index}[StylisticSet = 2]

% Oldstyle tabular numbers inside tabular environment
\AtBeginEnvironment{tabular}{\addfontfeatures{Numbers={Uppercase, Monospaced}}}
\AtBeginEnvironment{tikzpicture}{\addfontfeatures{Numbers={Uppercase, Monospaced}}}
\renewcommand{\theequation}{ {\addfontfeatures{Numbers={Uppercase, Monospaced}}\arabic{equation}}}

% Set linespacing to 1.1 times the point size, this sets baseline skip to almost exactly 136% which is what Matthew Butterick used in his example
\setstretch{1.1}

% Strong widow and orphan control - avoid any widows and orphans
\clubpenalty10000
\widowpenalty10000

% French Spacing - single spacing between sentences
\frenchspacing

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

\setbeamerfont{title}{series=\sffamily, size=\LARGE}
\setbeamerfont{subtitle}{series=\sansc, size=\large}
\setbeamerfont{author}{series=\sffamily, size=\normalsize}
\setbeamerfont{date}{series=\sffamily, size=\normalsize}
\setbeamerfont{institute}{series=\sffamily, size=\normalsize}
\setbeamerfont{frametitle}{series=\sansc, size=\large}
\setbeamerfont{section title}{series=\sansc, size=\Large}
\setbeamercolor{normal text}{bg=bgcolor, fg=fgcolor}
\setbeamercolor{frametitle}{bg=bgcolor, fg=fgcolor}
\setbeamercolor{footnote}{fg=fgcolor, bg=bgcolor}

% PGF grid style
\pgfplotsset{grid style={dashed,fgcolor}}

%===============================================================================
%=================================== footnotes =================================

\setbeamertemplate{footline}{\vspace{6.7pt}}
\setbeamertemplate{logo}{
	\usebeamercolor[fg]{footline}
	\usebeamerfont{page number in head/foot}\vspace{-7pt}
	\usebeamertemplate*{frame numbering}\hspace{5pt}
}

\renewcommand\footnotemargin{\parindent}

\renewcommand{\@makefntext}[1]{%
	\noindent \hbox to \z@{\hss{\textsuperscript{\@thefnmark}} \hfil}#1
}

% Add footnote without a superscript
\newcommand\blfootnote[1]{%
 \begingroup
 \renewcommand\thefootnote{}\footnote{#1}%
 \addtocounter{footnote}{-1}%
 \endgroup
}

%===============================================================================
%====================================== toc ====================================

\setbeamertemplate{section in toc}{
    {\nfwc\inserttocsectionnumber} \inserttocsection\par
}

%===============================================================================
%==================================== lists ====================================

\setbeamerfont{enumerate item}{family = \nfwc}

%===============================================================================
%==================================== linguex ==================================

\RequirePackage{etoolbox}
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

\renewcommand{\theExLBr}{\nfwc}
\renewcommand{\theExRBr}{\nfwc}

% Spacing between sub examples
\patchcmd{\a}{\itemsep\z@}{\itemsep.66\baselineskip}{}{}
            
%=================================== figures ===================================

\graphicspath{{figures/}}

%=================================== caption ====================================

\RequirePackage{caption,subcaption}
\captionsetup{labelformat=empty, justification=centering}


%================================ standout =====================================

\setbeamerfont{standout}{size=\Large, series=\upshape}

%============================== bibliography ===================================

% Hyperref setup
\RequirePackage{hyperref}
\hypersetup{
            colorlinks,
            breaklinks,
            linkcolor=fgcolor,
            urlcolor=AmmaBlue,
            citecolor=fgcolor,
            filecolor=fgcolor
    }

\def\UrlFont{\tt}

% Bibliography settings
\if@biblatex
   % Bibliography settings
   \RequirePackage[backend=biber,
                   style=authoryear,
                   natbib,
                   maxcitenames=1,
                   maxbibnames=999,
                   sorting=none,
                   url=false,
                   doi=false,
                   eprint=false]{biblatex}
    
    \setlength\bibitemsep{0.5\baselineskip}
    
    \setbeamertemplate{bibliography item}{}
    
    % Set size of citation text
    \renewcommand*{\citesetup}{\normalsize}
    
    % Set size of bib text
    \renewcommand*{\bibfont}{\tiny}
    
    % Reset bibliography entry title to non-bold
    \setbeamerfont{bibliography entry title}{size=\normalsize, series=\upshape}
    
    \addbibresource{references.bib}
\fi

%===============================================================================
%=============================== metadata ======================================

\hypersetup{
    pdfauthor={Venkat},
    pdfcreator={Venkat},
    pdftitle=\@title,
}
