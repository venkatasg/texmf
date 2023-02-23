%=====================================================================
%============================ Definition =============================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mycv}[2023/07/18 v1.0.0 my curriculum vitae and résumé class]


%=====================================================================
%======================= page setup & options ========================

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
\geometry{top=1.25in, bottom=1.25in, left=1.25in, right=1.25in}

%=====================================================================
%=========================== base packages ===========================

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
    colorlinks=true,
    allcolors=color2,
    baseurl       = http://,
    pdfborder     = 0 0 0,
    pdfpagemode   = \pdfpagemode,
    pdfstartpage  = 1,
    pdfcreator    = {TexLive},
%    pdfproducer   = {\LaTeX{}},% will/should be set automatically to the correct TeX engine used
    bookmarksopen = true,
    bookmarksdepth= 2,% to show sections and subsections
    pdfauthor     = {\@firstname{}~\@lastname{}},
    pdftitle      = {\@firstname{}~\@lastname{} -- CV},
    pdfsubject    = {CV of \@firstname{}~\@lastname{}},
    pdfkeywords   = {\@firstname{}~\@lastname{}, curriculum vit\ae{}, resum\'{e}}}}

% graphics
\RequirePackage{graphicx}

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

% advanced command arguments (LaTeX 3)
\RequirePackage{xparse}
% TODO (?): replace all \newcommand by \NewDocumentCommand

% micro-typography (e.g., character protrusion, font expansion, hyphenatable letterspacing)
\RequirePackage[final,protrusion={true,compatibility}, expansion=true]{microtype}

% stack of key-value elements, used to save personal information
\RequirePackage{moderncvcollection}


%=====================================================================
%============================= typography ============================

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

% Set linespacing to 1.1 times the point size
\RequirePackage{setspace}
\setstretch{1.1}

% French Spacing - single spacing between sentences
\frenchspacing

%-------------------------------------------------------------------------------
%                class definition
%-------------------------------------------------------------------------------
% minimal base settings
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength{\parindent}{0\p@}
\setlength{\parskip}{0\p@}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}

\raggedbottom
\onecolumn


%-------------------------------------------------------------------------------
%                overall design commands definitions
%-------------------------------------------------------------------------------
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

% adds a fixed/mobile/fax number to one's personal information (optional)
% usage: \phone[<optional type>]{<number>}
% where <optional type> should be either "fixed" (default), "mobile" or "fax
\collectionnew{phones}
\newcommand*{\phone}[2][fixed]{\collectionadd[#1]{phones}{#2}}

% adds a social link to one's personal information (optional)
% usage: \social[<optional type>][<optional url>]{<account name>}
% where <optional type> should be either "linkedin", "twitter" or "github"
\collectionnew{socials}
\NewDocumentCommand{\social}{O{}O{}m}{%
  \ifthenelse{\equal{#2}{}}%
    {%
      \ifthenelse{\equal{#1}{linkedin}}{\collectionadd[linkedin]{socials}{\protect\href{https://linkedin.com/in/#3}{#3}}}{}%
      \ifthenelse{\equal{#1}{twitter}} {\collectionadd[twitter]{socials} {\protect\href{https://twitter.com/#3}{#3}}}    {}%
      \ifthenelse{\equal{#1}{github}}  {\collectionadd[github]{socials}  {\protect\href{https://github.com/#3}{#3}}}     {}%
    }
    {\collectionadd[#1]{socials}{\protect\href{#2}{#2}}}}

% defines additional personal information (optional)
% usage: \extrainfo{<text>}
\newcommand*{\extrainfo}[1]{\def\@extrainfo{#1}}

%=====================================================================
%============================== colors ===============================

\RequirePackage[table]{xcolor}
\definecolor{color0}{HTML}{000000} % main default color, normally left to black
\definecolor{color1}{HTML}{D73A49} % --color-scale-red-5
\definecolor{color2}{HTML}{0366D6} % --color-scale-blue-5

%=====================================================================
%=============================== icons ===============================

% symbols
%--------
% itemize labels (the struts were added to correct inter-item spacing (works for single line items, until a solution is found for multi-line ones...)
\newcommand*{\labelitemi}          {\strut\textcolor{color1}{\large\rmfamily\textbullet}}% the \rmfamily is required to force Latin Modern fonts when using sans serif, as OMS/lmss/m/n is not defined and gets substituted by OMS/cmsy/m/n
\newcommand*{\labelitemii}         {\strut\textcolor{color1}{\large\bfseries-}}
\newcommand*{\labelitemiii}        {\strut\textcolor{color1}{\rmfamily\textperiodcentered}}% alternative: \textasteriskcentered; the \rmfamily is required to force Latin Modern fonts when using sans serif, as OMS/lmss/m/n is not defined and gets substituted by OMS/cmsy/m/n
\newcommand*{\labelitemiv}         {\labelitemiii}

% enumerate labels
\renewcommand{\theenumi}           {\@arabic\c@enumi}
\renewcommand{\theenumii}          {\@alph\c@enumii}
\renewcommand{\theenumiii}         {\@roman\c@enumiii}
\renewcommand{\theenumiv}          {\@Alph\c@enumiv}

% other symbols
\newcommand*{\listitemsymbol}      {\labelitemi~}
\newcommand*{\addresssymbol}       {}
\newcommand*{\mobilephonesymbol}   {}
\newcommand*{\fixedphonesymbol}    {}
\newcommand*{\faxphonesymbol}      {}
\newcommand*{\emailsymbol}         {}
\newcommand*{\homepagesymbol}      {}
\newcommand*{\linkedinsocialsymbol}{}
\newcommand*{\xingsocialsymbol}    {}
\newcommand*{\twittersocialsymbol} {}
\newcommand*{\githubsocialsymbol}  {}
\newcommand*{\gitlabsocialsymbol}  {}
\newcommand*{\skypesocialsymbol}   {}
\newcommand*{\stackoverflowsocialsymbol}   {}
\newcommand*{\bitbucketsocialsymbol}   {}
\newcommand*{\orcidsocialsymbol}   {}
\newcommand*{\researchgatesocialsymbol}   {}
\newcommand*{\researchidsocialsymbol}   {}
\newcommand*{\telegramsocialsymbol}   {}
\newcommand*{\googlescholarsocialsymbol}   {}

% symbols
\RequirePackage{moderncviconsawesome}

% other
%------
% fonts


% strings for internationalisation
\newcommand*{\refname}{Publications}
\newcommand*{\enclname}{Enclosure}

% recomputes all automatic lengths
\newcommand*{\recomputeheadlengths}{\recomputecvheadlengths}
\newcommand*{\recomputebodylengths}{\recomputecvbodylengths}
\newcommand*{\recomputefootlengths}{\recomputecvfootlengths}
\newcommand*{\recomputelengths}{\recomputecvlengths}
\AtBeginDocument{\recomputelengths{}}

% creates a command if not yet defined
\newcommand*{\@initializecommand}[2]{%
  \ifdefined#1
    \renewcommand{#1}{#2}%
  \else%
    \newcommand*{#1}{#2}\fi}

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

% creates an if switch if not yet defined
\newcommand*{\@initializeif}[1]{%
%  \ifdefined#1% not working due to the nested \if
%  \else%
    \newif#1%\fi
  }

% custom strut for spacing; the first argument is the vertical offset of the strut, the second its total height
\newcommand*{\@moderncvstrut}[2]{%
  \rule[-#1]{0pt}{#2}}


%-------------------------------------------------------------------------------
%                resume design commands definitions
%-------------------------------------------------------------------------------
% elements
% defines one's picture (optional)
% usage: photo[<picture width>][<picture frame thickness>]{<picture filename>}
\NewDocumentCommand{\photo}{O{64pt}O{0.4pt}m}{\def\@photowidth{#1}\def\@photoframewidth{#2}\def\@photo{#3}}
\newcommand*{\quote}[1]{\def\@quote{#1}}

% fonts
\newcommand*{\namefont}{}
\newcommand*{\titlefont}{}
\newcommand*{\addressfont}{}
\newcommand*{\quotefont}{}
\newcommand*{\sectionfont}{}
\newcommand*{\subsectionfont}{}
\newcommand*{\hintfont}{}
\newcommand*{\pagenumberfont}{\addressfont\itshape}

% styles
\newcommand*{\namestyle}[1]{{\namefont#1}}
\newcommand*{\titlestyle}[1]{{\titlefont#1}}
\newcommand*{\addressstyle}[1]{{\addressfont#1}}
\newcommand*{\quotestyle}[1]{{\quotefont#1}}
\newcommand*{\sectionstyle}[1]{{\sectionfont#1}}
\newcommand*{\subsectionstyle}[1]{{\subsectionfont#1}}
\newcommand*{\hintstyle}[1]{{\hintfont#1}}
\newcommand*{\pagenumberstyle}[1]{{\pagenumberfont#1}}

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

% makes a resume line 2 headers and their corresponding text
% usage: \cvdoubleitem[spacing]{header1}{text1}{header2}{text2}
\newcommand*{\cvdoubleitem}[5][.25em]{}

% makes a resume line with a list item
% usage: \cvlistitem[label]{item}
\newcommand*{\cvlistitem}[2][\listitemsymbol]{}

% makes a resume line with 2 list items
% usage: \cvlistdoubleitem[label]{item1}{item2}
\newcommand*{\cvlistdoubleitem}[3][\listitemsymbol]{}

% makes a typical resume job / education entry
% usage: \cventry[spacing]{years}{degree/job title}{institution/employer}{localization}{optionnal: grade/...}{optional: comment/job description}
\newcommand*{\cventry}[7][.25em]{}

% makes a resume entry with a proficiency comment
% usage: \cvitemwithcomment[spacing]{header}{text}{comment}
\newcommand*{\cvitemwithcomment}[4][.25em]{}

% cvcolumns environment, where every column is created through \cvcolumn
% usage: \begin{cvcolumns}
%          \cvcolumn[width]{head}{content}
%          \cvcolumn[width]{head}{content}
%          ...
%        \end{cvcolumns}
% where "width" is the width as a fraction of the line length (between 0 and 1), "head" is the column header and "content" its content
\newcounter{cvcolumnscounter}% counter for the number of columns
\newcounter{cvcolumnsautowidthcounter}% counter for the number of columns with no column width provided, and which will then be equally distributed
\newcounter{tmpiteratorcounter}% counter for any temporary purpose (e.g., iterating loops)
\newlength{\cvcolumnsdummywidth}\setlength{\cvcolumnsdummywidth}{1000pt}% dummy width for total width, in order to enable arithmetics (TeX has no float variables, only integer counters or lengths)
\newlength{\cvcolumnswidth}% total width available for head / content
\newlength{\cvcolumnsautowidth}% total width of columns with no explicit width provided
\newlength{\cvcolumnautowidth}% width of one of the columns with no explicit width provided (based on equal distribution of remaining space)
\newif\if@cvcolumns@head@empty% whether or not at least one of the columns has a header
\newenvironment*{cvcolumns}%
  {% at environment opening: reset counters, lengths and ifs
    \setcounter{cvcolumnscounter}{0}%
    \setcounter{cvcolumnsautowidthcounter}{0}%
    \setlength{\cvcolumnsautowidth}{\cvcolumnsdummywidth}%
    \setlength{\cvcolumnautowidth}{0pt}%
    \@cvcolumns@head@emptytrue\ignorespaces}%
  {% at environment closing: typeset environment
    % compute the width of each cvcolumn, considering a spacing of \separatorcolumnwidth and the columns with set width
    \ifnum\thecvcolumnscounter>0%
      \setlength{\cvcolumnswidth}{\maincolumnwidth-\value{cvcolumnscounter}\separatorcolumnwidth+\separatorcolumnwidth}%
      \setlength{\cvcolumnautowidth}{\cvcolumnswidth*\ratio{\cvcolumnsautowidth}{\cvcolumnsdummywidth}/\value{cvcolumnsautowidthcounter}}\fi%
    \def\cvcolumns@def{}%
    \def\cvcolumns@head{}%
    \def\cvcolumns@content{}%
    \setcounter{tmpiteratorcounter}{0}%
    % loop based on \g@addto@macro
    \loop\ifnum\thetmpiteratorcounter<\thecvcolumnscounter%
      \ifnum\thetmpiteratorcounter=0\else%
        \g@addto@macro\cvcolumns@def{@{\hspace*{\separatorcolumnwidth}}}%
        \g@addto@macro\cvcolumns@head{&}%
        \g@addto@macro\cvcolumns@content{&}\fi%
%      \expandafter\g@addto@macro\expandafter\cvcolumns@def\expandafter{\csname cvcolumn\roman{tmpiteratorcounter}@def\endcsname}%      % this creates issues with the colortbl" package (loaded by xcolor when passing the "table" option) as the column definitions passed to \begin{tabular} contains \cvcolumn<i>@def references that it doesn't understand; the next 2 lines expand \cvcolumn@def to the point it doesn't
      \edef\tmpcvcolumn@def{\csname cvcolumn\roman{tmpiteratorcounter}@def\endcsname}%
      \expandafter\g@addto@macro\expandafter\cvcolumns@def\expandafter{\tmpcvcolumn@def}%
      \expandafter\g@addto@macro\expandafter\cvcolumns@head\expandafter{\csname cvcolumn\roman{tmpiteratorcounter}@head\endcsname}%
      \expandafter\g@addto@macro\expandafter\cvcolumns@content\expandafter{\csname cvcolumn\roman{tmpiteratorcounter}@content\endcsname}%
      \stepcounter{tmpiteratorcounter}%
      \repeat%
%    % same loop based on \protected@edef
%    \loop\ifnum\thetmpiteratorcounter<\thecvcolumnscounter%
%      \ifnum\thetmpiteratorcounter=0\else%
%        \protected@edef\cvcolumns@def{\cvcolumns@def @{\hspace*{\separatorcolumnwidth}}}%
%        \protected@edef\cvcolumns@head{\cvcolumns@head &}%
%        \protected@edef\cvcolumns@content{\cvcolumns@content &}\fi%
%      \expandafter\protected@edef\expandafter\cvcolumns@def\expandafter{\expandafter\cvcolumns@def\expandafter\protect\csname cvcolumn\roman{tmpiteratorcounter}@def\endcsname}%
%      \expandafter\protected@edef\expandafter\cvcolumns@head\expandafter{\expandafter\cvcolumns@head\expandafter\protect\csname cvcolumn\roman{tmpiteratorcounter}@head\endcsname}%
%      \expandafter\protected@edef\expandafter\cvcolumns@content\expandafter{\expandafter\cvcolumns@content\expandafter\protect\csname cvcolumn\roman{tmpiteratorcounter}@content\endcsname}%
%      \stepcounter{tmpiteratorcounter}%
%      \repeat%
    % create the tabular
    \cvitem{}{%
%      \begin{tabular}{\cvcolumns@def}% this conflicts with the "colortbl" package (loaded by xcolor when passing the "table" option), and requires the below 2 lines to expand \cvcolumns@def
      \def\begincvcolumns{\begin{tabular}[t]}% "[t]" is required for some body styles; the default alignment is "[c]"
      \expandafter\begincvcolumns\expandafter{\cvcolumns@def}%
        \if@cvcolumns@head@empty\else%
          \cvcolumns@head%\\[-.8em]%
%          {\color{color1}\rule{\maincolumnwidth}{.25pt}}%
          \\\fi%
        \cvcolumns@content%
      \end{tabular}}}

% cvcolumn command, to create a column inside a cvcolumns environment
% usage: \cvcolumn[width]{head}{content}
% where "width" is the width as a fraction of the line length (between 0 and 1), "head" is the column header and "content" its content ("head" and "content" can contain "\\", "\newline" or any other paragraph command such as "itemize")
\newcommand*{\cvcolumn}[3][\cvcolumnautowidth]{%
%  \def\cvcolumn@width{}%
  \ifthenelse{\equal{#1}{\cvcolumnautowidth}}%
    {% if no width fraction is provided, count this column as auto-adjusted and set its width to \cvcolumnsautowidth
      \stepcounter{cvcolumnsautowidthcounter}%
      \expandafter\expandafter\expandafter\def\expandafter\csname cvcolumn\roman{cvcolumnscounter}@def\endcsname{p{\cvcolumnautowidth}}%
      \expandafter\expandafter\expandafter\def\expandafter\csname cvcolumn\roman{cvcolumnscounter}@head\endcsname{\protect\parbox[b]{\cvcolumnautowidth}{\protect\subsectionstyle{#2}}}}%
    {% if a width is provided, set the width of the column to it and decrease the available space for auto-adjusted columns
      \addtolength{\cvcolumnsautowidth}{-#1\cvcolumnsdummywidth}%
      \expandafter\expandafter\expandafter\def\expandafter\csname cvcolumn\roman{cvcolumnscounter}@def\endcsname{p{#1\cvcolumnswidth}}%
      \expandafter\expandafter\expandafter\def\expandafter\csname cvcolumn\roman{cvcolumnscounter}@head\endcsname{\protect\parbox[b]{#1\cvcolumnswidth}{\protect\subsectionstyle{#2}}}}%
  \ifthenelse{\equal{#2}{}}{}{\@cvcolumns@head@emptyfalse}%
  \expandafter\expandafter\expandafter\def\expandafter\csname cvcolumn\roman{cvcolumnscounter}@content\endcsname{\protect\cvcolumncell{#3}}%
  \stepcounter{cvcolumnscounter}%
  \ignorespaces}

% internal cvcolumncell command, that enables a cvcolumn cell to contain paragraph commands (lists, newlines, etc)
\newcommand*{\cvcolumncell}[1]{{% put cell inside a group, so that command redefinitions are only local
  % roughly restore \\ to its regular definition (outside of tabular)
  \renewcommand*{\\}{\newline}%
  % enclose the contents of the cell inside a vertical box, to allow paragraph commands
  \protect\vtop{#1}}}

% thebibliography environment, for use with BibTeX and possibly multibib
\newlength{\bibindent}
\setlength{\bibindent}{1.5em}
% bibliography item label
\newcommand*{\bibliographyitemlabel}{}% use \@biblabel{\arabic{enumiv}} for BibTeX labels
%\newif\if@multibibfirstbib\@multibibfirstbibfalse
% bibliography head (section, etc}, depending on whether multibib is used
\newcommand*{\bibliographyhead}[1]{\section{#1}}
\AtEndPreamble{\@ifpackageloaded{multibib}{\renewcommand*{\bibliographyhead}[1]{\subsection{#1}}}{}}
% thebibliography environment definition
\newenvironment{thebibliography}[1]{}{}
\newcommand*{\newblock}{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
%% fix a bug (hardcoded bib label) in \@bibitem
%\renewcommand\@bibitem[1]{%
%  \item\if@filesw \immediate\write\@auxout
%    {\string\bibcite{#1}{\theenumiv}}\fi\ignorespaces}% replaced "\the\value{\@listctr}" with "\theenumiv"

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

% classical \today definition
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}

%=====================================================================
%=============================== header ==============================

% fonts
\renewcommand*{\namefont}{\Huge\sffamily}
\renewcommand*{\titlefont}{\large\sansc}
\renewcommand*{\addressfont}{\small\sffamily}
\renewcommand*{\quotefont}{\large\itshape}

% styles
\renewcommand*{\namestyle}[1]{{\namefont\textcolor{color1}{#1}}}
\renewcommand*{\titlestyle}[1]{{\titlefont{#1}}}
\renewcommand*{\addressstyle}[1]{{\addressfont{#1}}}
\renewcommand*{\quotestyle}[1]{{\quotefont{#1}}}

% lengths
\@initializelength{\quotewidth}
\@initializelength{\makecvheadnamewidth}% optional makecvheadname width to force a certain width (if set/remains to 0pt, the width is calculated automatically)
\renewcommand*{\recomputecvheadlengths}{%
  \setlength{\quotewidth}{0.65\textwidth}}

% commands
\renewcommand*{\makecvhead}{%
  % recompute lengths (in case we are switching from letter to resume, or vice versa)
  \recomputecvlengths%
  % optional detailed information (pre-rendering)
  \@initializebox{\makecvheaddetailsbox}%
    \def\phonesdetails{}%
    \collectionloop{phones}{% the key holds the phone type (=symbol command prefix), the item holds the number
      \protected@edef\phonesdetails{\phonesdetails\protect\makenewline\csname\collectionloopkey phonesymbol\endcsname\collectionloopitem}}%
    \def\socialsdetails{}%
    \collectionloop{socials}{% the key holds the social type (=symbol command prefix), the item holds the link
      \protected@edef\socialsdetails{\socialsdetails\protect\makenewline\csname\collectionloopkey socialsymbol\endcsname\collectionloopitem}}%
    \savebox{\makecvheaddetailsbox}{%
      \addressfont%
      \begin{tabular}[b]{@{}r@{}}
        \ifthenelse{\isundefined{\@addressstreet}}{}{\makenewline\addresssymbol\@addressstreet%
          \ifthenelse{\equal{\@addresscity}{}}{}{\makenewline\@addresscity}% if \addresstreet is defined, \addresscity and addresscountry will always be defined but could be empty
          \ifthenelse{\equal{\@addresscountry}{}}{}{\makenewline\@addresscountry}}%
        \ifthenelse{\isundefined{\@born}}{}{\makenewline\bornsymbol\@born}%
        \phonesdetails% needs to be pre-rendered as loops and tabulars seem to conflict
        \ifthenelse{\isundefined{\@email}}{}{\makenewline\emailsymbol\href{mailto:\@email}{\@email}}%
        \ifthenelse{\isundefined{\@homepage}}{}{\makenewline\homepagesymbol\href{https://\@homepage}{\@homepage}}%
        \socialsdetails% needs to be pre-rendered as loops and tabulars seem to conflict
        \ifthenelse{\isundefined{\@extrainfo}}{}{\makenewline\@extrainfo}%
      \end{tabular}
    }
  % optional photo (pre-rendering)
  \@initializebox{\makecvheadpicturebox}%
  \savebox{\makecvheadpicturebox}{%
    \ifthenelse{\isundefined{\@photo}}%
      {}%
      {%
        \hspace*{\separatorcolumnwidth}
        \color{color1}%
        \setlength{\fboxrule}{\@photoframewidth}%
        \ifdim\@photoframewidth=0pt%
          \setlength{\fboxsep}{0pt}\fi%
        \framebox{\includegraphics[width=\@photowidth]{\@photo}}}}%
  % name and title (pre-rendering)
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
  \\[-1em]%
  % optional quote
  \ifthenelse{\isundefined{\@quote}}%
    {}%
    {{\centering\begin{minipage}{\quotewidth}\centering\quotestyle{\@quote}\end{minipage}\\[2.5em]}}%
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
%   used by \cvdoubleitem
\@initializelength{\doubleitemcolumnwidth}
%   used by \cvlistitem
\@initializelength{\listitemsymbolwidth}          \settowidth{\listitemsymbolwidth}{\listitemsymbol}
\@initializelength{\listitemcolumnwidth}
%   used by \cvlistdoubleitem
\@initializelength{\listdoubleitemcolumnwidth}

% commands
\renewcommand*{\recomputecvbodylengths}{%
  % body lengths
  \setlength{\maincolumnwidth}{\textwidth-\leftskip-\rightskip}%
  \setlength{\listitemcolumnwidth}{\maincolumnwidth-\listitemsymbolwidth}%
  \setlength{\doubleitemcolumnwidth}{\maincolumnwidth-\separatorcolumnwidth}%
  \setlength{\doubleitemcolumnwidth}{0.5\doubleitemcolumnwidth}%
  \setlength{\listdoubleitemcolumnwidth}{\maincolumnwidth-\listitemsymbolwidth-\separatorcolumnwidth-\listitemsymbolwidth}%
  \setlength{\listdoubleitemcolumnwidth}{0.5\listdoubleitemcolumnwidth}%
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
  \par\nobreak\addvspace{1ex}\@afterheading
}

\RenewDocumentCommand{\subsection}{sm}{%
  \par\addvspace{1ex}
  \phantomsection{}
  \strut\subsectionstyle{#2}
  \par\nobreak\addvspace{0.5ex}\@afterheading
}

\newcommand*{\sectionrule}{}
\newcommand*{\subsectionrule}{}

% Line after section
\renewcommand*{\sectionrule}{\par\nobreak\vspace*{-0.55\baselineskip}\leavevmode{\color{color1}\leaders\hbox{\rule{1pt}{0.4pt}}\hfill\kern0pt}}
\renewcommand*{\subsectionrule}{}

\renewcommand*{\cvitem}[3][.25em]{%
  \ifthenelse{\equal{#2}{}}{}{\hintstyle{#2}: }{#3}%
  \par\addvspace{#1}}

\renewcommand*{\cvdoubleitem}[5][.25em]{%
  \begin{minipage}[t]{\doubleitemcolumnwidth}\hintstyle{#2}: #3\end{minipage}%
  \hfill% fill of \separatorcolumnwidth
  \begin{minipage}[t]{\doubleitemcolumnwidth}\ifthenelse{\equal{#4}{}}{}{\hintstyle{#4}: }#5\end{minipage}%
  \par\addvspace{#1}}

\renewcommand*{\cvlistitem}[2][.25em]{%
  \listitemsymbol\begin{minipage}[t]{\listitemcolumnwidth}#2\end{minipage}%
  \par\addvspace{#1}}

\renewcommand*{\cvlistdoubleitem}[3][.25em]{%
  \cvitem[#1]{}{\listitemsymbol\begin{minipage}[t]{\listdoubleitemcolumnwidth}#2\end{minipage}%
  \hfill% fill of \separatorcolumnwidth
  \ifthenelse{\equal{#3}{}}%
    {}%
    {\listitemsymbol\begin{minipage}[t]{\listdoubleitemcolumnwidth}#3\end{minipage}}}}

\renewcommand*{\cventry}[5][0.75em]{
  \addvspace{#1}
  \begin{tabular*}{\maincolumnwidth}{l@{\extracolsep{\fill}}r}%
    {\large #4} & {\large #5}\\[0.15em]%
    \rule{0pt}{0.25em}{\itshape #3} & {\footnotesize \rmsc #2}\\[0.15em]%
  \end{tabular*}%
  \par}

\@initializebox{\cvitemwithcommentmainbox}
\@initializelength{\cvitemwithcommentmainlength}
\@initializelength{\cvitemwithcommentcommentlength}
\renewcommand*{\cvitemwithcomment}[4][.25em]{%
  \savebox{\cvitemwithcommentmainbox}{\ifthenelse{\equal{#2}{}}{}{\hintstyle{#2}: }#3}%
  \setlength{\cvitemwithcommentmainlength}{\widthof{\usebox{\cvitemwithcommentmainbox}}}%
  \setlength{\cvitemwithcommentcommentlength}{\maincolumnwidth-\separatorcolumnwidth-\cvitemwithcommentmainlength}%
  \begin{minipage}[t]{\cvitemwithcommentmainlength}\usebox{\cvitemwithcommentmainbox}\end{minipage}%
  \hfill% fill of \separatorcolumnwidth
  \begin{minipage}[t]{\cvitemwithcommentcommentlength}\raggedleft\small\itshape#4\end{minipage}%
  \par\addvspace{#1}}


%=====================================================================
%=============================== final ===============================

\RequirePackage[style=my-style,
                backend=biber,
                sorting=none,
                maxbibnames=6,
                minbibnames=4,
                uniquename=false,
                giveninits]{biblatex}
\setlength\bibitemsep{\itemsep}

\AtEndPreamble{
    \nocite{*}
}

% Beginning of document stuff
\AtBeginDocument{
    \normalfont\color{color0}
}

\endinput



%% end of file `practical-cv.cls'.
