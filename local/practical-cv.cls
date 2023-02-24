%===============================================================================
%================================= Definition ==================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mycv}[2023/07/18 v1.0.0 my curriculum vitae and résumé class]

%===============================================================================
%============================= page setup & options ============================

% paper size option
\DeclareOption{a4paper}{
  \setlength\paperheight{297mm}
  \setlength\paperwidth{210mm}}
\DeclareOption{a5paper}{
  \setlength\paperheight{210mm}
  \setlength\paperwidth{148mm}}
\DeclareOption{b5paper}{
  \setlength\paperheight{250mm}
  \setlength\paperwidth{176mm}}
\DeclareOption{letterpaper}{
  \setlength\paperheight{11in}
  \setlength\paperwidth{8.5in}}
\DeclareOption{legalpaper}{
  \setlength\paperheight{14in}
  \setlength\paperwidth{8.5in}}
\DeclareOption{executivepaper}{
  \setlength\paperheight{10.5in}
  \setlength\paperwidth{7.25in}}
\DeclareOption{landscape}{
  \setlength\@tempdima{\paperheight}
  \setlength\paperheight{\paperwidth}
  \setlength\paperwidth{\@tempdima}}

% font size options
\newcommand\@ptsize{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

% draft/final option
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}

% execute default options
\ExecuteOptions{a4paper,11pt,final}

% process given options
\ProcessOptions\relax
\input{size1\@ptsize.clo}

% Page margins
\RequirePackage{geometry}
\geometry{top=1.4in, bottom=1.4in, left=1.25in, right=1.25in}

%===============================================================================
%==================================== base =====================================

% Alignment and one column
\RequirePackage[document]{ragged2e}
\raggedbottom
\onecolumn

% Set linespacing to 1.1 times the point size
\RequirePackage{setspace}
\setstretch{1.1}

% No indent
\RequirePackage{parskip}

% \AtEndPreamble hook (loading etoolbox instead of defining the macro, as to avoid incompatibilities with etoolbox (and packages relying on it) defining the macro too)
\RequirePackage{etoolbox}

% Last page package
\RequirePackage{lastpage}

% if... then... else... constructs
\RequirePackage{ifthen}
% TODO: move to xifthen and \isempty{<arg>} instead of \equal{<arg>}{}

% hyper links (hyperref is loaded at the end of the preamble to pass options required by loaded packages such as CJK)
\newcommand*\pdfpagemode{UseNone}% do not show thumbnails or bookmarks on opening (on supporting browsers); set \pdfpagemode to "UseOutlines" to show bookmarks
\RequirePackage{url}
\urlstyle{tt}

\AtEndPreamble{
  \pagenumbering{arabic}% has to be issued before loading hyperref, as to set \thepage and hence to avoid hyperref issuing a warning and setting pdfpagelabels=false
  \RequirePackage[unicode]{hyperref}% unicode is required for unicode pdf metadata
  \hypersetup{
    breaklinks,
    colorlinks    = true,
    allcolors     = color2,
    baseurl       = https://,
    pdfborder     = 0 0 0,
    pdfpagemode   = \pdfpagemode,
    pdfstartpage  = 1,
    pdfcreator    = {TexLive},
    bookmarksopen = true,
    bookmarksdepth= 1,
    pdfauthor     = {\@firstname{}~\@lastname{}},
    pdftitle      = {\@firstname{}~\@lastname{} -- CV},
    pdfsubject    = {CV of \@firstname{}~\@lastname{}},
    pdfkeywords   = {\@firstname{}~\@lastname{}, curriculum vit\ae{}, r\'{e}sum\'{e}}}}

% headers and footers
\RequirePackage{fancyhdr}
\fancypagestyle{plain}{
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhf{}}

% page numbers in footer if more than 1 page
\AtEndPreamble{%
  \AtBeginDocument{%
        \ifthenelse{\pageref{LastPage}>1}{\cfoot{\sansc page \thepage\ of \pageref{LastPage}}}{}
      }
    }
\pagestyle{plain}

% reduced list spacing
% package providing hooks into lists
%   originally developped by Jakob Schiøtz (see http://dcwww.camd.dtu.dk/~schiotz/comp/LatexTips/tweaklist.sty)
%   modified and distributed with moderncv(not available otherwise on ctan)
\RequirePackage{tweaklist}
\renewcommand*{\itemhook}{%
  \@minipagetrue% removes spacing before lists as they use \addvspace, which doesn't add vertical space inside minipages
  \@noparlisttrue% removes spacing at end of lists, caused by \par
  \setlength{\topsep}{0pt}% normally not required thanks to \@minipagetrue
  \setlength{\partopsep}{0pt}% normally not required thanks to \@minipagetrue
  \setlength{\parsep}{0pt}% not required when \itemsep and \parskip are set to 0pt (?)
  \setlength{\parskip}{0pt}%
  \setlength{\itemsep}{0pt}}
\renewcommand*{\enumhook}{\itemhook{}}
\renewcommand*{\deschook}{\itemhook{}}

% lengths calculations
\RequirePackage{calc}

% micro-typography (e.g., character protrusion, font expansion, hyphenatable letterspacing)
\RequirePackage[final,protrusion={true,compatibility}, expansion=true]{microtype}

% stack of key-value elements, used to save personal information
\RequirePackage{moderncvcollection}

% creates a length if not yet defined
\newcommand*{\@initializelength}[1]{%
  \ifdefined#1
  \else%
    \newlength{#1}\fi%
  \setlength{#1}{0pt}}

% creates a box if not yet defined
\newcommand*{\@initializebox}[1]{%
  \ifdefined#1
    \savebox{#1}{}%
  \else%
    \newsavebox{#1}\fi}

%===============================================================================
%================================= typography ==================================

\RequirePackage{unicode-math}
\setmainfont{Equity A}[Numbers={Lowercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]
\setsansfont{Concourse 3}[Numbers={Lowercase,Proportional}, Contextuals=Alternate, SmallCapsFeatures={LetterSpace=3, Renderer=Basic}]

\newfontfamily{\sansc}{Concourse 3 Caps}[Letters=UppercaseSmallCaps, Numbers={Lowercase,Proportional}]
\newfontfamily{\rmsc}{Equity A Caps}[Letters=UppercaseSmallCaps, Numbers={Lowercase,Proportional}]
\newfontfamily{\sancs}{Concourse 3 Caps}[Numbers={Uppercase,Proportional}]
\newfontfamily{\rmcs}{Equity A Caps}[Numbers={Uppercase,Proportional}]

% IPA, monospace, and math fonts
\newfontfamily{\ipa}{Charis SIL}
\setmonofont[Scale=MatchLowercase]{Triplicate A Code}
\setmathfont[Path=/Users/venkat/Library/Fonts/, Extension=.otf,Scale=MatchLowercase,Ligatures=TeX, BoldFont=XCharter-Math-Bold]{XCharter-Math}

% Oldstyle tabular numbers inside tabular environment
\AtBeginEnvironment{tabular}{\addfontfeatures{Numbers={Uppercase, Monospaced}}\small}
\renewcommand{\theequation}{ {\addfontfeatures{Numbers={Uppercase, Monospaced}}\small\arabic{equation}}}

% French Spacing - single spacing between sentences
\frenchspacing

%===============================================================================
%============================== personal details ===============================
% elements
%---------
% defines one's name
% usage: \name{<firstname>}{<lastname>}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}

% defines one's title (optional)
% usage: \title{<title>}
\renewcommand*{\title}[1]{\def\@title{#1}}

% defines one's address (optional)
% usage: \address{<street>}{<city>}{<country>}
% where the <city> and <country> arguments can be omitted or provided empty
\NewDocumentCommand{\address}{mG{}G{}}{\def\@addressstreet{#1}\def\@addresscity{#2}\def\@addresscountry{#3}}

% defines one's email (optional)
% usage: \email{<email adress>}
\newcommand*{\email}[1]{\def\@email{#1}}

% defines one's home page (optional)
% usage: \homepage{<url>}
\newcommand*{\homepage}[1]{\def\@homepage{#1}}

% add phone number
% usage: \phone{<phone number>}
\newcommand*{\phone}[1]{\def\@phone{#1}}

% add social media links to one's personal information
% usage: \social[<optional type>][<optional url>]{<account name>}
% where <optional type> should be either "linkedin", "twitter" or "github"
\collectionnew{socials}
\NewDocumentCommand{\social}{O{}O{}m}{
  \ifthenelse{\equal{#2}{}}{
      \ifthenelse{\equal{#1}{linkedin}}{\collectionadd[linkedin]{socials}{\protect\href{https://linkedin.com/in/#3}{#3}}}{}%
      \ifthenelse{\equal{#1}{twitter}} {\collectionadd[twitter]{socials} {\protect\href{https://twitter.com/#3}{#3}}}    {}%
      \ifthenelse{\equal{#1}{github}}  {\collectionadd[github]{socials}  {\protect\href{https://github.com/#3}{#3}}}     {}%
    }
    {\collectionadd[#1]{socials}{\protect\href{#2}{#2}}}
}

%===============================================================================
%=================================== colors ====================================

\RequirePackage[table]{xcolor}
\definecolor{color0}{HTML}{000000} % black color
\definecolor{color1}{HTML}{D73A49} % github red
\definecolor{color2}{HTML}{0366D6} % wikipedia blue

%===============================================================================
%=================================== icons =====================================

% symbols
%--------
% itemize labels (the struts were added to correct inter-item spacing (works for single line items, until a solution is found for multi-line ones...)
\newcommand*{\labelitemi}          {\strut\textcolor{color1}{\large\rmfamily\textbullet}}% the \rmfamily is required to force Latin Modern fonts when using sans serif, as OMS/lmss/m/n is not defined and gets substituted by OMS/cmsy/m/n
\newcommand*{\labelitemii}         {\strut\textcolor{color1}{\large\bfseries-}}
\newcommand*{\labelitemiii}        {\strut\textcolor{color1}{\rmfamily\textperiodcentered}}% alternative: \textasteriskcentered; the \rmfamily is required to force Latin Modern fonts when using sans serif, as OMS/lmss/m/n is not defined and gets substituted by OMS/cmsy/m/n
\newcommand*{\labelitemiv}         {\labelitemiii}

% symbols
\RequirePackage{fontawesome5}

\newcommand*{\fixedphonesymbol}         {{\small\faPhone*}~}
\newcommand*{\emailsymbol}              {{\small\faEnvelope[regular]}~}
\newcommand*{\homepagesymbol}           {{\small\faGlobeAmericas}~}
\newcommand*{\linkedinsocialsymbol}     {{\small\faLinkedinIn}~}
\newcommand*{\githubsocialsymbol}       {{\small\faGithub}~}

%===============================================================================
%================================== commands ===================================

% fonts
\newcommand*{\namefont}{}
\newcommand*{\titlefont}{}
\newcommand*{\addressfont}{}
\newcommand*{\sectionfont}{}
\newcommand*{\subsectionfont}{}
\newcommand*{\hintfont}{}

% styles
\newcommand*{\namestyle}[1]{{\namefont#1}}
\newcommand*{\titlestyle}[1]{{\titlefont#1}}
\newcommand*{\addressstyle}[1]{{\addressfont#1}}
\newcommand*{\sectionstyle}[1]{{\sectionfont#1}}
\newcommand*{\subsectionstyle}[1]{{\subsectionfont#1}}
\newcommand*{\hintstyle}[1]{{\hintfont#1}}

% recompute all resume lengths
\newcommand*{\recomputecvheadlengths}{}
\newcommand*{\recomputecvbodylengths}{}
\newcommand*{\recomputecvfootlengths}{}
\newcommand*{\recomputecvlengths}{%
  \recomputecvheadlengths%
  \recomputecvbodylengths%
  \recomputecvfootlengths}

% internal maketitle command to issue a new line only when required
\newif\if@firstdetailselement\@firstdetailselementtrue
\newcommand*{\makenewline}[1][0pt]{%
  \if@firstdetailselement%
    \strut% to ensure baseline alignment, e.g. with when put in the margin vs sections that also contains a \strut
  \else%
    \\[#1]\fi%
  \@firstdetailselementfalse}

% makes the resume title
% usage: \makecvtitle
\newcommand*{\makecvtitle}{%
  \makecvhead%
  \makecvfoot}
\newcommand*{\makecvhead}{}
\newcommand*{\makecvfoot}{}

% makes a resume section
% usage: \section{<title>}
% identical starred and non-starred variants should be defined for compatibility with other packages (e.g. with natbib, that uses \section*{} for the bibliography header)
\NewDocumentCommand{\section}{sm}{}

% makes a resume subsection
% usage: \subsection{title}
\NewDocumentCommand{\subsection}{sm}{}

% makes a resume line with a header and a corresponding text
% usage: \cvitem[spacing]{header}{text}
\newcommand*{\cvitem}[3][.25em]{}

% makes a typical resume job / education entry
% usage: \cventry[spacing]{years}{degree/job title}{institution/employer}{localization}{optionnal: grade/...}{optional: comment/job description}
\newcommand*{\cventry}[8][.25em]{}

% itemize, enumerate and description environment
\setlength{\leftmargini}   {1em}
\leftmargin\leftmargini
\setlength{\leftmarginii}  {\leftmargini}
\setlength{\leftmarginiii} {\leftmargini}
\setlength{\leftmarginiv}  {\leftmargini}
\setlength{\leftmarginv}   {\leftmargini}
\setlength{\leftmarginvi}  {\leftmargini}
\setlength{\labelsep}      {.5em}% this is the distance between the label and the body, but it pushes the label to the left rather than pushing the body to the right (to do the latter, modify \leftmargin(i)
\setlength{\labelwidth}    {\leftmargini}% unfortunately, \labelwidth is not defined by item level (i.e. no \labeliwidth, \labeliiwidth, etc)
\addtolength{\labelwidth}  {-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\p@enumii(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
% description label
\newcommand*\descriptionlabel[1]{\hspace\labelsep\normalfont\bfseries#1}

%===============================================================================
%==================================== header ===================================

% fonts
\renewcommand*{\namefont}{\Huge\sffamily}
\renewcommand*{\titlefont}{\large\sansc}
\renewcommand*{\addressfont}{\small\sffamily}

% styles
\renewcommand*{\namestyle}[1]{{\namefont\textcolor{color1}{#1}}}
\renewcommand*{\titlestyle}[1]{{\titlefont{#1}}}
\renewcommand*{\addressstyle}[1]{{\addressfont{#1}}}

% lengths
\@initializelength{\makecvheadnamewidth}% optional makecvheadname width to force a certain width (if set/remains to 0pt, the width is calculated automatically)

% commands
\renewcommand*{\makecvhead}{%
  % recompute lengths (in case we are switching from letter to resume, or vice versa)
  \recomputecvlengths%
  % optional detailed information (pre-rendering)
  \@initializebox{\makecvheaddetailsbox}
    \def\socialsdetails{}
    \collectionloop{socials}{
        % the key holds the social type (=symbol command prefix), the item holds the link
        \protected@edef\socialsdetails{\socialsdetails\protect\makenewline\csname\collectionloopkey socialsymbol\endcsname\collectionloopitem}
    }
    \savebox{\makecvheaddetailsbox}{%
      \addressfont%
      \begin{tabular}[b]{@{}r@{}}
        \ifthenelse{\isundefined{\@phone}}{}{\makenewline\fixedphonesymbol\href{tel:\@phone}{\@phone}}
        \ifthenelse{\isundefined{\@email}}{}{\makenewline\emailsymbol\href{mailto:\@email}{\@email}}
        \ifthenelse{\isundefined{\@homepage}}{}{\makenewline\homepagesymbol\href{https://\@homepage}{\@homepage}}
        \socialsdetails% needs to be pre-rendered as loops and tabulars seem to conflict
      \end{tabular}
    }

  % name and title (pre-rendering)
  \@initializebox{\makecvheadpicturebox}
  \@initializelength{\makecvheaddetailswidth}\settowidth{\makecvheaddetailswidth}{\usebox{\makecvheaddetailsbox}}%
  \@initializelength{\makecvheadpicturewidth}\settowidth{\makecvheadpicturewidth}{\usebox{\makecvheadpicturebox}}%
  \ifthenelse{\lengthtest{\makecvheadnamewidth=0pt}}% check for dummy value (equivalent to \ifdim\makecvheadnamewidth=0pt)
    {\setlength{\makecvheadnamewidth}{\textwidth-\makecvheaddetailswidth-\makecvheadpicturewidth}}%
    {}%
  \@initializebox{\makecvheadnamebox}%
  \savebox{\makecvheadnamebox}{%
    \begin{minipage}[b]{\makecvheadnamewidth}%
      \raggedright
      \namestyle{\@firstname\ \@lastname}%
      \ifthenelse{\equal{\@title}{}}{}{\\[0.5\baselineskip]\titlestyle{\@title}}%
    \end{minipage}}%
  % rendering
    \usebox{\makecvheadnamebox}%
    \hfill%
    \llap{\usebox{\makecvheaddetailsbox}}% \llap is used to suppress the width of the box, allowing overlap if the value of makecvheadnamewidth is forced
    \usebox{\makecvheadpicturebox}
  \\[-1em]
  \par}% to avoid weird spacing bug at the first section if no blank line is left after \makecvhead


%===============================================================================
%=============================== body definition ===============================

% fonts
\renewcommand*{\sectionfont}{%
  \large\bfseries\sansc
}

\renewcommand*{\subsectionfont}{%
  \normalsize\itshape
}

\renewcommand*{\hintfont}{\bfseries}

% styles
\renewcommand*{\sectionstyle}[1]{{
  \sectionfont\textcolor{color1}{#1}
}}

\renewcommand*{\subsectionstyle}[1]{{
  \subsectionfont{#1}
}}

\renewcommand*{\hintstyle}[1]{{\hintfont\textcolor{color1}{#1}}}


% lengths
%   used by \cvitem (and all children command)
\@initializelength{\hintscolumnwidth}             \setlength{\hintscolumnwidth}{0.3\textwidth}
\@initializelength{\separatorcolumnwidth}         \setlength{\separatorcolumnwidth}{0.025\textwidth}
\@initializelength{\maincolumnwidth}

% commands
\renewcommand*{\recomputecvbodylengths}{%
  % body lengths
  \setlength{\maincolumnwidth}{\textwidth-\leftskip-\rightskip}
  % regular lengths
  \setlength{\parskip}{0\p@}}

\RenewDocumentCommand{\section}{sm}{%
  \par\addvspace{\baselineskip}%
  \phantomsection{}
  % Ensures that the sectionrule and the heading are on the same page
  \vbox{
  \sectionrule\\
  \sectionstyle{#2}
  }
  \par\nobreak\addvspace{0.5\baselineskip}\@afterheading
}

\RenewDocumentCommand{\subsection}{sm}{%
  \par\addvspace{0.5\baselineskip}
  \phantomsection{}
  \strut\subsectionstyle{#2}
  \par\nobreak\addvspace{0.25\baselineskip}\@afterheading
}

\newcommand*{\sectionrule}{}

% Line after section
\renewcommand*{\sectionrule}{\par\nobreak\leavevmode{\color{color1}\leaders\hbox{\rule{1pt}{0.4pt}}\hfill\kern0pt}}

\renewcommand*{\cvitem}[3][.25em]{%
  \ifthenelse{\equal{#2}{}}{}{\hintstyle{#2}: }{#3}%
  \par\addvspace{#1}}

\renewcommand*{\cventry}[6][1em]{
  \addvspace{#1}
  \begin{tabular*}{\maincolumnwidth}{l@{\extracolsep{\fill}}r}
    {\large #3} & {\large #4}\\[0.2em]
    {\normalsize\itshape #2} & {\footnotesize #5}\\[0.2em]
    \multicolumn{2}{p{\textwidth}}{\normalsize #6}\\
  \end{tabular*}%
  \par
}

%===============================================================================
%=============================== bibliography ==================================

\RequirePackage[style=my-style,
                backend=biber,
                sorting=none,
                maxbibnames=6,
                minbibnames=4,
                uniquename=false,
                giveninits]{biblatex}

% Set separation between bib entries
\setlength\bibitemsep{1em}

% Print all entries in bib file without explicit cite command
\AtEndPreamble{
    \nocite{*}
}

%===============================================================================
%=================================== final =====================================

% Beginning of document stuff
\AtBeginDocument{
    \normalfont\color{color0}
}

\endinput

