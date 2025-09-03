\NeedsTeXFormat{LaTeX2e}[1996/06/01]
\ProvidesClass{practical-letter}[2022/07/18 v1 Standard LaTeX document class]

%===============================================================================
%=================================== options ===================================
\newcommand\@ptsize{}
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

\if@compatibility
  \DeclareOption{twoside}{\@latexerr{No `twoside' layout for letters}%
                                   \@eha}
\else
  \DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\fi

\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}

\ExecuteOptions{letterpaper,11pt,oneside,onecolumn,final}
\ProcessOptions\relax
\input{size1\@ptsize.clo}

%===============================================================================
%===================================== base ====================================

% Alignment
\RequirePackage[document]{ragged2e}
\raggedbottom
\onecolumn

\RequirePackage[skip=\baselineskip]{parskip}

% Set textwidth to 2.3 times length of alphabet
\newlength{\alphabet}
\settowidth{\alphabet}{\normalfont abcdefghijklmnopqrstuvwxyz}
\RequirePackage{geometry}
\geometry{twoside=false, textwidth=2.3\alphabet, right=0.75in, top=0.75in, bottom=1in, headheight=0pt, headsep=0pt, footnotesep=0pt, footskip=0pt,marginparwidth=0in, marginparsep=0cm,}

% Set linespacing to 1.1 times the point size
\RequirePackage{setspace}
\setstretch{1.1}

% For including signature
\RequirePackage{graphicx}

% if then macro
\RequirePackage{ifthen}

%===============================================================================
%=================================== commands ==================================

\newcommand*\name[1]{\def\fromname{#1}}
\newcommand*\signature[1]{\def\fromsig{#1}}
\newcommand*\address[1]{\def\fromaddress{#1}}
\newcommand*\location[1]{\def\fromlocation{#1}}
\newcommand*\phone[1]{\def\phonenum{#1}}
\newcommand*\email[1]{\def\emailaddr{#1}}
\newcommand*\website[1]{\def\webaddr{#1}}

\newcommand*\addressee[1]{\def\toaddress{#1}}
\newcommand*\subject[1]{\def\fromsubject{#1}}

\newcommand*\encl[1]{
  \par\noindent
  \parbox[t]{\textwidth}{
    \@hangfrom{\normalfont~encl: }
    \ignorespaces #1\strut}\par
}

\newcommand*\ps{\par\startbreaks}

\newcommand*\cc[1]{
  \par\noindent
  \parbox[t]{\textwidth}{
    \@hangfrom{\normalfont\ccname: }
    \ignorespaces #1\strut}\par
}

%===============================================================================
%================================== typography =================================

\RequirePackage{unicode-math}
\setmainfont{Equity A}[
    Numbers={Lowercase,Proportional}, 
    Contextuals=Alternate,
    ]
\setsansfont{Concourse 3}[
    Numbers={Lowercase,Proportional}, 
    Contextuals=Alternate,
    ]

\newfontfamily{\sansc}{Concourse 3 Caps}[Letters=UppercaseSmallCaps, LetterSpace=5, Numbers={Lowercase,Proportional}]
\newfontfamily{\rmsc}{Equity A Caps}[Letters=UppercaseSmallCaps, LetterSpace=5, Numbers={Lowercase,Proportional}]
\newfontfamily{\sancs}{Concourse 3 Caps}[Letters=Uppercase, LetterSpace=5, Numbers={Uppercase,Proportional}]
\newfontfamily{\rmcs}{Equity A Caps}[Letters=Uppercase, LetterSpace=5, Numbers={Uppercase,Proportional}]


% Oldstyle tabular numbers inside tabular environment
\AtBeginEnvironment{tabular}{\addfontfeatures{Numbers={Uppercase, Monospaced}}\small}
\renewcommand{\theequation}{ {\addfontfeatures{Numbers={Uppercase, Monospaced}}\small\arabic{equation}}}

% Strong widow and orphan control - avoid any widows and orphans
\clubpenalty10000
\widowpenalty10000

% French Spacing - single spacing between sentences
\frenchspacing

% icons for social sites
\RequirePackage{fontawesome5}

%===============================================================================
%============================= opening & closing ===============================

% Opening
\newcommand*\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}

\newcommand*\opening[1]{
    \vspace{-2\baselineskip}
    \pagestyle{empty}
    \@date\par
    \toaddress\par
    {\bfseries\fromsubject\par\nobreak}\par
    #1\par\nobreak
}

% Closing
\newcommand\closing[1]{
    \vspace{\baselineskip}
    \ifthenelse{\equal{\fromsig}{}}{
        \parbox{0.5\textwidth}{
            \raggedright
            \ignorespaces #1\\[3\baselineskip]
            \fromname\strut
        }
    }
    {
        \parbox{0.5\textwidth}{
            \raggedright
            \ignorespaces #1\\[\baselineskip]
            \hspace*{-2mm}\includegraphics[width=0.35\textwidth]{\fromsig}\\
            \fromname\strut
        }
    }
    \par
}

%===============================================================================
%================================== recipient ==================================

\RequirePackage[absolute]{textpos}

\newcommand*\senderbox{
    \begin{textblock*}{47mm}(19mm,15.5mm) %Placed to have same left margin as right, and a little above top margin to account for the spacing above text in this box I can't seem to remove
        \sansc\color{MokaRed!80}
        {\sancs\bfseries\fromname}\par
        \vspace{\baselineskip}
        {\fromaddress}\par
        \vspace{\baselineskip}
        {{\small\faGlobe}~\webaddr}\\
        {{\small\faEnvelope[regular]}~\emailaddr}\\
        {{\small\faPhone*}~\phonenum}
    \end{textblock*}
    \color{black}
}
%===============================================================================
%=========================== Color & links =====================================
% color
\RequirePackage[table]{xcolor}

% Lighter version of red for sender
\definecolor{MokaRed}{HTML}{D83A49} % my red

% Colors for links
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
    plainpages=true,
    pdfpagelabels,
    bookmarks=false,
    pdfstartview=FitH,
    backref
}
