\NeedsTeXFormat{LaTeX2e}[1996/06/01]
\ProvidesClass{practical-letter}[2022/02/21 v1 Standard LaTeX document class]

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
\ProcessOptions


\input{size1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0.7em}
\setlength\parindent{0\p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setlength\headheight{12\p@}
\setlength\headsep   {45\p@}
\setlength\footskip{25\p@}
\if@compatibility
  \setlength\textwidth{365\p@}
  \setlength\textheight{505\p@}
\fi
\if@compatibility
  \setlength\oddsidemargin{53pt}
  \setlength\evensidemargin{53pt}
  \setlength\marginparwidth{90pt}
\else
  \setlength\@tempdima{\paperwidth}
  \addtolength\@tempdima{-2in}
  \addtolength\@tempdima{-\textwidth}
  \setlength\oddsidemargin   {.5\@tempdima}
  \setlength\evensidemargin  {\oddsidemargin}
  \setlength\marginparwidth  {90\p@}
\fi
\setlength\marginparsep {11\p@}
\setlength\marginparpush{5\p@}
\setlength\topmargin{27pt}
\setlength\footnotesep{12\p@}
\setlength{\skip\footins}{10\p@ \@plus 2\p@ \@minus 4\p@}


\newcommand*\name[1]{\def\fromname{#1}}
\newcommand*\signature[1]{\def\fromsig{#1}}
\newcommand*\address[1]{\def\fromaddress{#1}}
\newcommand*\location[1]{\def\fromlocation{#1}}
\newcommand*\telephone[1]{\def\telephonenum{#1}}
\newcommand*\email[1]{\def\emailaddr{#1}}

\name{}
\signature{}
\address{}
\location{}
\telephone{}
\email{}

\newcommand*\makelabels{%
  \AtBeginDocument{%
     \let\@startlabels\startlabels
     \let\@mlabel\mlabel
     \if@filesw
       \immediate\write\@mainaux{\string\@startlabels}\fi}%
  \AtEndDocument{%
     \if@filesw\immediate\write\@mainaux{\string\clearpage}\fi}}
\@onlypreamble\makelabels

\newenvironment{letter}[1]{
    \newpage
    \interlinepenalty=200 % smaller than the TeXbook value
    \@processto{\leavevmode\ignorespaces #1}
}{
    \stopletter\@@par\pagebreak\@@par
    \if@filesw
      \begingroup
        \let\\=\relax
        \let\protect\@unexpandable@protect
        \immediate\write\@auxout{%
          \string\@mlabel{\returnaddress}{\toname\\\toaddress}}%
      \endgroup
    \fi
}
\long\def\@processto#1{%
  \@xproc #1\\@@@%
  \ifx\toaddress\@empty
  \else
    \@yproc #1@@@%
  \fi}
\long\def\@xproc #1\\#2@@@{\def\toname{#1}\def\toaddress{#2}}
\long\def\@yproc #1\\#2@@@{\def\toaddress{#2}}

\newcommand*\stopbreaks{%
  \interlinepenalty\@M
  \def\par{\@@par\nobreak}%
  \let\\\@nobreakcr
  \let\vspace\@nobreakvspace}
\DeclareRobustCommand\@nobreakvspace
   {\@ifstar\@nobreakvspacex\@nobreakvspacex}
\def\@nobreakvspacex#1{%
  \ifvmode
    \nobreak\vskip #1\relax
  \else
    \@bsphack\vadjust{\nobreak\vskip #1}\@esphack
  \fi}
\def\@nobreakcr{\@ifstar{\@normalcr*}{\@normalcr*}}
\newcommand*\startbreaks{%
  \let\\\@normalcr
  \interlinepenalty 200%
  \def\par{\@@par\penalty 200\relax}}
\newdimen\longindentation
\longindentation=.5\textwidth
\newdimen\indentedwidth
\indentedwidth=\textwidth
\advance\indentedwidth -\longindentation

% Opening
\newcommand*\opening[1]{
    \pagestyle{empty}
    \raggedright
    \@date\par
    \vspace{\baselineskip}%
    \toname \expandafter\\\toaddress \par
    \vspace{\baselineskip}%
    #1\par\nobreak
}

% Closing
\newcommand\closing[1]{
    \vspace{\baselineskip}
    \parbox{\indentedwidth}{\raggedright
       \ignorespaces #1\\[6\medskipamount]%
       \ifx\@empty\fromsig
           \fromname
       \else \fromsig \fi\strut
       }%
    \par
}

\newcommand*\subject[1]{
    \vspace{\baselineskip}
    \raggedright
    {\bfseries#1\par\nobreak}
}

\medskipamount=\parskip
\newcommand*\cc[1]{%
  \par\noindent
  \parbox[t]{\textwidth}{%
    \@hangfrom{\normalfont\ccname: }%
    \ignorespaces #1\strut}\par}

\newcommand*\encl[1]{%
  \par\noindent
  \parbox[t]{\textwidth}{%
    \@hangfrom{\normalfont\enclname: }%
    \ignorespaces #1\strut}\par}

\newcommand*\ps{\par\startbreaks}
\newcommand*\stopletter{}
\newcommand*\returnaddress{}
\newcount\labelcount
\newcommand*\startlabels{\labelcount\z@
  \pagestyle{empty}%
  \let\@texttop\relax
  \topmargin -50\p@
  \headsep \z@
  \oddsidemargin -35\p@
  \evensidemargin -35\p@
  \textheight 10in
  \@colht\textheight  \@colroom\textheight \vsize\textheight
  \textwidth 550\p@
  \columnsep 26\p@
  \ifcase \@ptsize\relax
    \normalsize
  \or
    \small
  \or
    \footnotesize
  \fi
  \baselineskip \z@
  \lineskip \z@
  \boxmaxdepth \z@
  \parindent \z@
  \twocolumn\relax}
\let\@startlabels=\relax
\newcommand*\mlabel[2]{%
  \parbox[b][2in][c]{262\p@}{\strut\ignorespaces #2}%
  }
\let\@mlabel=\@gobbletwo
\setlength\leftmargini   {2.5em}
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\setlength\leftmarginv   {1em}
\setlength\leftmarginvi  {1em}
\setlength\leftmargin    {\leftmargini}
\setlength  \labelsep  {5\p@}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\setlength\partopsep{0\p@}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\def\@listI{\setlength\leftmargin{\leftmargini}%
            \setlength\parsep {0\p@}%
            \setlength\topsep {.4em}%
            \setlength\itemsep{.4em}}
\let\@listi\@listI
\@listi
\def\@listii {\setlength  \leftmargin{\leftmarginii}%
              \setlength  \labelwidth{\leftmarginii}%
              \addtolength\labelwidth{-\labelsep}}
\def\@listiii{\setlength  \leftmargin{\leftmarginiii}%
              \setlength  \labelwidth{\leftmarginiii}%
              \addtolength\labelwidth{-\labelsep}%
              \setlength  \topsep    {.2em}%
              \setlength  \itemsep   {\topsep}}
\def\@listiv {\setlength  \leftmargin{\leftmarginiv}%
              \setlength  \labelwidth{\leftmarginiv}%
              \addtolength\labelwidth{-\labelsep}}
\def\@listv  {\setlength  \leftmargin{\leftmarginv}%
              \setlength  \labelwidth{\leftmarginv}%
              \addtolength\labelwidth{-\labelsep}}
\def\@listvi {\setlength  \leftmargin{\leftmarginvi}%
              \setlength  \labelwidth{\leftmarginvi}%
              \addtolength\labelwidth{-\labelsep}}
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi  {\labelitemfont \textbullet}
\newcommand\labelitemii {\labelitemfont \bfseries \textendash}
\newcommand\labelitemiii{\labelitemfont \textasteriskcentered}
\newcommand\labelitemiv {\labelitemfont \textperiodcentered}
\newcommand\labelitemfont{\normalfont}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                 \normalfont\bfseries #1}
\newenvironment{verse}
               {\let\\=\@centercr
                \list{}{\setlength\itemsep{\z@}%
                        \setlength\itemindent{-15\p@}%
                        \setlength\listparindent{\itemindent}%
                        \setlength\rightmargin{\leftmargin}%
                        \addtolength\leftmargin{15\p@}}%
                \item[]}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\setlength\listparindent{1.5em}%
                        \setlength\itemindent{\listparindent}%
                        \setlength\rightmargin{\leftmargin}}%
                \item[]}
               {\endlist}
\newenvironment{quote}
               {\list{}{\setlength\rightmargin{\leftmargin}}%
                \item[]}
               {\endlist}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\renewcommand\theequation{\@arabic\c@equation}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\relax}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\relax}
\DeclareRobustCommand*{\cal}{\@fontswitch{\relax}{\mathcal}}
\DeclareRobustCommand*{\mit}{\@fontswitch{\relax}{\mathnormal}}
\renewcommand\footnoterule{%
  \kern-\p@
  \hrule \@width .4\columnwidth
  \kern .6\p@}
\newcommand\@makefntext[1]{%
    \noindent
    \hangindent 5\p@
    \hb@xt@5\p@{\hss\@makefnmark}#1}
\newcommand*\ccname{cc}
\newcommand*\enclname{encl}
\newcommand*\pagename{Page}
\newcommand*\headtoname{To}
\newcommand*\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\def\@texttop{\ifnum\c@page=1\vskip \z@ plus.00006fil\relax\fi}
\onecolumn
\raggedbottom




% Set textwidth to 2.3 times length of alphabet
\newlength{\alphabet}
\settowidth{\alphabet}{\normalfont abcdefghijklmnopqrstuvwxyz}
\RequirePackage[showframe]{geometry}
\geometry{paper=letterpaper, twoside=false, textwidth=2.3\alphabet, right=0.75in, top=1in, bottom=1in, headheight=0pt, headsep=0pt, footnotesep=0pt, footskip=0pt,marginparwidth=0in, marginparsep=0cm,}

% Left alignment
% \RequirePackage[document]{ragged2e}

% parskip
% \RequirePackage[skip=\baselineskip]{parskip}

% Set linespacing to 1.1 times the point size
\RequirePackage{setspace}
\setstretch{1.1}


%=====================================================================
%============================= typography ============================

\RequirePackage{unicode-math}
\setmainfont{Equity A}[Numbers={Lowercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
\setsansfont{Concourse 3}[Numbers={Lowercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]

\newfontfamily{\sansc}{Concourse 3 Caps}[Letters=UppercaseSmallCaps, Numbers={Lowercase,Proportional}]
\newfontfamily{\rmsc}{Equity A Caps}[Letters=UppercaseSmallCaps, Numbers={Lowercase,Proportional}]
\newfontfamily{\sancs}{Concourse 3 Caps}[Letters=Uppercase, Numbers={Uppercase,Proportional}]
\newfontfamily{\rmcs}{Equity A Caps}[Letters=Uppercase, Numbers={Uppercase,Proportional}]

% Oldstyle tabular numbers inside tabular environment
\AtBeginEnvironment{tabular}{\addfontfeatures{Numbers={Uppercase, Monospaced}}\small}
\renewcommand{\theequation}{ {\addfontfeatures{Numbers={Uppercase, Monospaced}}\small\arabic{equation}}}

% Strong widow and orphan control - avoid any widows and orphans
\clubpenalty10000
\widowpenalty10000

% French Spacing - single spacing between sentences
\frenchspacing

%=====================================================================
%============================= left margin ============================

\RequirePackage{xcolor}
\definecolor{from-color}{HTML}{404040} % gray

\endinput
