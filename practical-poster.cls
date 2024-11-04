% Practical poster template based on
%%%% Better Poster latex template v1.0 (2019/04/04)
%%%% GNU General Public License v3.0
%%%% Rafael Bailo
%%%% https://github.com/rafaelbailo/betterposter-latex-template
%%%% 
%%%% Original design from Mike Morrison
%%%% https://twitter.com/mikemorrison

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{practical-poster}[2019/04/04 Better Poster latex template v1.0]

%% "article" as the base class
\LoadClass{article}
\pagestyle{empty}

%%%% REQUIRED PACKAGES

%% Paper size
\RequirePackage{geometry} 
\geometry{a0paper}

%% Paper orientation
\geometry{portrait}

%% Remove default margins
\geometry{margin=0in}

%% AMS packages
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{booktabs}
\RequirePackage{graphicx}
\RequirePackage{csquotes}
\RequirePackage[font=normalsize,labelfont={sc, Large}]{caption}
\RequirePackage{pgfplots}
\pgfplotsset{compat=newest}
\RequirePackage{setspace}
\RequirePackage{parskip}
\RequirePackage{tcolorbox}
\RequirePackage{titlesec}
\RequirePackage{linguex}
\RequirePackage{ragged2e}
\RequirePackage{multicol} 
\RequirePackage{ragged2e}
\columnsep=0.03\textwidth
\columnseprule=0pt

%% Font
\RequirePackage{unicode-math}
\setmainfont{Heliotrope 3}[Numbers={Lowercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
\setsansfont{Heliotrope 3}[Numbers={Lowercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
\newfontfamily{\smallcaps}{Heliotrope 4 Caps}[Letters=UppercaseSmallCaps, Numbers={Lowercase,Proportional}, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
\newfontfamily{\allcaps}{Heliotrope 4 Caps}[Letters=Uppercase, Numbers={Uppercase,Proportional}]
\setmonofont[Scale=MatchLowercase]{Triplicate A Code}

% Fancy Numbering fonts
\newfontfamily{\nfwc}{Concourse T3 Index}
\newfontfamily{\nfbc}{Concourse T3 Index}[StylisticSet = 2]

%% Small separation on enumerate and itemize
\RequirePackage{enumitem}
\setlist{nolistsep}
\setenumerate{noitemsep}
\setitemize{noitemsep}
\setlength{\parindent}{0pt}

%===============================================================================
%============================== colors =========================================
\RequirePackage{xcolor}
\definecolor{burntorange}{HTML}{bf5700}
\definecolor{paleorange}{HTML}{fff1e3}
\definecolor{bluelinkcolor}{HTML}{0366D6}
\definecolor{darkgrey}{HTML}{404040}
\definecolor{ithacablue}{HTML}{003c71}

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

\newcommand{\rowbackgroundcolor}{white}
\newcommand{\rowfontcolor}{black}
\newcommand{\mainfindingbackgroundcolor}{burntorange}
\newcommand{\mainfindingfontcolor}{white}

%% Graphics
\RequirePackage{graphicx}


%%%% SIZE COMMANDS

%% Poster lengths
\newlength{\mainfindingheight}
\newlength{\bottomboxheight}
\newlength{\middleboxheight}
\newlength{\marginvertical}

%%%% SIZING OPTIONS

\newcommand{\fontsizesmall}{\fontsize{28.00}{30.00} \selectfont}
\newcommand{\fontsizestandard}{\fontsize{38.00}{48.00} \selectfont}
\newcommand{\fontsizemain}{\fontsize{100.00}{150.00} \selectfont}
\newcommand{\fontsizetitle}{\fontsize{80.00}{130.00} \selectfont}
\newcommand{\fontsizeauthor}{\fontsize{48.00}{68.00} \selectfont}
\newcommand{\fontsizesection}{\fontsize{48.00}{68.00} \selectfont}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%% Default values for lengths
\setlength{\mainfindingheight}{0.4\paperheight}
\setlength{\bottomboxheight}{0.05\paperheight}
\setlength{\middleboxheight}{0.52\paperheight}
\setlength{\marginvertical}{0.07\paperwidth}

%===============================================================================
%============================== hypersetup =====================================

% Hyperref setup
\RequirePackage{hyperref}
\hypersetup{
            colorlinks,
            breaklinks,
            linkcolor=black,
            urlcolor=bluelinkcolor,
            citecolor=black,
            filecolor=black
    }

\def\UrlFont{\tt}


\DeclareCaptionLabelFormat{smallcaps-plain}{\fontsizestandard\smallcaps#1 #2} 
\DeclareCaptionLabelSeparator{bigcolon}{\fontsizestandard: }
\captionsetup{labelformat=smallcaps-plain,labelsep=bigcolon}

%%%% TEMPLATE COMMANDS

%% Section command
\titleformat{\section}{\raggedright\smallcaps\fontsizesection\bfseries}{}{0pt}{}
\titlespacing{\section}{0pt}{0.5\baselineskip}{0.5\baselineskip}
\titleformat*{\paragraph}{\raggedright\fontsizestandard\bfseries}

% Institution command
\def\@affiliation{\relax}
\newcommand{\affiliation}[1]{
  \def\@affiliation{\color{darkgrey}#1}
}

\newcommand\alert[1]{\textcolor{burntorange}{#1}}

\def\@logo{\relax}
\newcommand{\logo}[1]{
  \def\@logo{#1}
}

% The header
\newcommand\makepostertitle{
    \centering
    \begin{minipage}[t]{\textwidth}
        \vspace{3\baselineskip}
        {\noindent\raggedright\fontsizetitle\bfseries\par\@title}
        \vspace{2\baselineskip}
        {\fontsizeauthor\par\color{darkgrey}\@author}
        \vspace{0.5\baselineskip}
        {\fontsizestandard\par\color{darkgrey}\@affiliation}
    \end{minipage}
    \vspace{0.5\baselineskip}
}


%% Main row command
\newcommand{\mainfinding}[1]{
    \noindent\colorbox{\mainfindingbackgroundcolor}{
        \begin{minipage}[c][\mainfindingheight]{\textwidth}
            \centering
            \fontsizemain\color{\mainfindingfontcolor} 
            \begin{tabular}{p{0.95\textwidth}}
                #1 \\
            \end{tabular}
        \end{minipage}
    }
}

% Begin \middlebox command
\newcommand{\middlebox}[1]{
	\noindent\makebox[\textwidth][c]{
		\begin{minipage}[t][\middleboxheight]{0.95\textwidth}    
			\centering          
			\makepostertitle
			\setstretch{1.1}
			\fontsizestandard
			\color{\rowfontcolor}
			#1     
		\end{minipage}	
	}
}
% End \middlebox command


% Begin \bottombox command
\newcommand{\bottombox}[1]{
    \begin{minipage}[b][\bottomboxheight]{\textwidth}
    	\hbox{\color{burntorange}\rule{\pagewidth}{2mm}}
		\vspace{\baselineskip}
        \centering
        \begin{minipage}{0.79\textwidth}    
            \fontsizestandard\quad#1
        \end{minipage}
        \begin{minipage}{0.2\linewidth}
            \centering  
            \includegraphics[width=0.7\textwidth]{\@logo}
        \end{minipage}
    \end{minipage}
} 

