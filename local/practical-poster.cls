\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{practical-poster}[2023/07/18 a0poster custom class]


%===============================================================================
%======================== option declarations ==================================

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{a0poster}}

\ProcessOptions\relax
\LoadClass[a0, portrait]{a0poster}

%===============================================================================
%========================= required packages ===================================

\RequirePackage{booktabs}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{csquotes}
\RequirePackage[font=normalsize,labelfont=bf]{caption}
\RequirePackage{pgfplots}
\pgfplotsset{compat=newest}
\RequirePackage{setspace}
\setstretch{1.2}
\RequirePackage{parskip}
\RequirePackage{tcolorbox}
\RequirePackage[export]{adjustbox}
\RequirePackage{titlesec}
\RequirePackage{linguex}


%===============================================================================
%============================ page setup =======================================

\RequirePackage{geometry}
\geometry{a0paper, left=2in, top=1in, right=2in, bottom=2in}

\RequirePackage{multicol} 
\columnsep=80pt 
\columnseprule=0pt 


%===============================================================================
%============================== colors =========================================

\definecolor{burntorange}{HTML}{bf5700}
\definecolor{paleorange}{HTML}{fff1e3}
\definecolor{bluelinkcolor}{HTML}{0366D6}

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

\pgfplotscreateplotcyclelist{mbarplot cycle}{%
  {draw=TolDarkBlue,    fill=TolDarkBlue!70},
  {draw=TolLightBrown,  fill=TolLightBrown!70},
  {draw=TolLightGreen,  fill=TolLightGreen!70},
  {draw=TolDarkPink,    fill=TolDarkPink!70},
  {draw=TolDarkPurple,  fill=TolDarkPurple!70},
  {draw=TolDarkRed,     fill=TolDarkRed!70},
  {draw=TolDarkBrown,   fill=TolDarkBrown!70},
  {draw=TolLightRed,    fill=TolLightRed!70},
  {draw=TolLightPink,   fill=TolLightPink!70},
  {draw=TolLightPurple, fill=TolLightPurple!70},
  {draw=TolLightBlue,   fill=TolLightBlue!70},
  {draw=TolDarkGreen,   fill=TolDarkGreen!70},
}

%===============================================================================
%============================== typography =====================================

\RequirePackage{unicode-math}
\setmainfont{Heliotrope 4}[Numbers={Lowercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
\setsansfont{Heliotrope 4}[Numbers={Lowercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
\newfontfamily{\sansc}{Heliotrope 4 Caps}[Letters=UppercaseSmallCaps, Numbers={Lowercase,Proportional}, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
\newfontfamily{\sancs}{Heliotrope 4 Caps}[Letters=Uppercase, Numbers={Uppercase,Proportional}]
\setmonofont[Scale=MatchLowercase]{Triplicate A Code}

%===============================================================================
%============================== formatting =====================================

% define how our section titles will look (with ruled line)
\titleformat{\section}{\sc\sansc\huge\bfseries}{}{0pt}{}
\titlespacing{\section}{0pt}{0.5\baselineskip}{0.5\baselineskip}

\newtcolorbox{mainbox}[1]{width=\columnwidth, colback={paleorange}, colframe=burntorange, boxsep=1cm, arc=25pt, fonttitle={\centering\bfseries\sansc}, title=#1}

\let\oldcenter\center
\let\oldendcenter\endcenter
\renewenvironment{center}{\setlength\topsep{0.5\baselineskip}\oldcenter}{\oldendcenter}
\newcommand{\HRule}[1][\medskipamount]{\par
  \vspace*{\dimexpr-\parskip-\baselineskip+#1}
  \noindent\rule{\linewidth}{1pt}\par
  \vspace*{\dimexpr-\parskip-.5\baselineskip+#1}}

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

%===============================================================================
%============================ custom commands ==================================

\newcommand\alert[1]{\textcolor{burntorange}{#1}}

\def\@affiliation{\relax}
\newcommand{\affiliation}[1]{
  \def\@affiliation{#1}
}

\def\@logo{\relax}
\newcommand{\logo}[1]{
  \def\@logo{#1}
}

% The header is divided into two boxes, on the left is the text and on the right is the logo
\newcommand\makepostertitle{
    \begin{minipage}[t]{.75\linewidth}
        {\vspace{-1.1em}\raggedright\VeryHuge\bfseries\color{burntorange}\par\@title}
        \vspace{\baselineskip}
        {\Large\par\@author}
        \@affiliation
    \end{minipage}
    \begin{minipage}[t]{0.24\linewidth}  
        \includegraphics[width=0.8\textwidth, valign=t, right, trim={0 0 5 1}]{\@logo}
    \end{minipage}
    \vspace{\baselineskip}
}
