%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Options :
% draft/final
% paper/screen
% submitted/defended
% (no)lot/(no)lof/(no)lol
% (no)hyperref / (no)backref
% (no)minitoc
% (no)thanks
% (no)abstract
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mythesis}

\newif\if@draft\@drafttrue
\newif\if@paper\@paperfalse
\newif\if@lof\@loftrue
\newif\if@lol\@loltrue
\newif\if@lot\@lottrue
\newif\if@hyperref\@hyperreftrue
\newif\if@backref\@backreftrue
\newif\if@minitoc\@minitoctrue
\newif\if@thanks\@thankstrue
\newif\if@abstract\@abstracttrue

\DeclareOption{draft}{\@drafttrue}
\DeclareOption{final}{\@draftfalse}
\DeclareOption{paper}{\@papertrue}
\DeclareOption{screen}{\@paperfalse}
\DeclareOption{lof}{\@loftrue}
\DeclareOption{nolof}{\@loffalse}
\DeclareOption{lol}{\@loltrue}
\DeclareOption{nolol}{\@lolfalse}
\DeclareOption{lot}{\@lottrue}
\DeclareOption{nolot}{\@lotfalse}
\DeclareOption{hyperref}{\@hyperreftrue}
\DeclareOption{nohyperref}{\@hyperreffalse\@backreffalse}
\DeclareOption{backref}{\@backreftrue}
\DeclareOption{nobackref}{\@backreffalse}
\DeclareOption{minitoc}{\@minitoctrue}
\DeclareOption{nominitoc}{\@minitocfalse}
\DeclareOption{thanks}{\@thankstrue}
\DeclareOption{nothanks}{\@thanksfalse}
\DeclareOption{abstract}{\@abstracttrue}
\DeclareOption{noabstract}{\@abstractfalse}
\DeclareOption{defended}{\PassOptionsToPackage{defended}{mycover}}
\DeclareOption{submitted}{\PassOptionsToPackage{submitted}{mycover}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions

\PassOptionsToPackage{utf8}{inputenc}

\PassOptionsToClass{french}{memoir}

\if@draft
  \PassOptionsToClass{draft}{memoir}
\else
  \PassOptionsToClass{final}{memoir}
\fi

\if@hyperref\if@backref\PassOptionsToPackage{pagebackref}{hyperref}\fi\fi

\LoadClass[a4paper,12pt]{memoir}

\if@hyperref
  \RequirePackage[final]{hyperref}
  \if@backref
    \renewcommand*{\backref}[1]{}
    \renewcommand*{\backrefalt}[4]{%
      \ifcase #1%
        Non cit\'e.
      \or
        Cit\'e page #2.%
      \else
        Cit\'e pages #2.%
      \fi%
    }
  \fi
\fi

\if@minitoc\RequirePackage[nohints,loose,french]{minitoc}
\mtcsettitle{minitoc}{}
\setlength{\mtcindent}{0pt}
\mtcsetoffset{minitoc}{\wd\ChpNumBox+1em}
\mtcsetfeature{minitoc}{open}{\vspace{0ex}} % Setting vertical space between the empty contents title and the actual table of contents
\mtcsetfeature{minitoc}{before}{\vspace{-5ex}} % Setting vertical space before the empty contents title and previous elements.
\fi

\RequirePackage[T1]{fontenc}
\RequirePackage{inputenc}
\RequirePackage[square]{natbib}
\RequirePackage[english,french]{babel}
\RequirePackage{amsmath,amssymb}
\RequirePackage{boxedminipage}
\RequirePackage{calc}
\RequirePackage{color}
\RequirePackage{fourier}
\RequirePackage{listings,lstautogobble}
\RequirePackage[framemethod=tikz]{mdframed}
\RequirePackage{soul}
\RequirePackage{url}
\RequirePackage{xcolor}
\RequirePackage{memhfixc}
\RequirePackage{makeidx}
\RequirePackage{showidx}
\RequirePackage{mycover}
\RequirePackage{dsfont}
\RequirePackage{mathrsfs}
\RequirePackage[normalem]{ulem} 
\RequirePackage{alltt}
\RequirePackage{fancyvrb}
\RequirePackage{sansmath}
\RequirePackage{multirow}
\RequirePackage{multicol}
\RequirePackage{color, colortbl}
\usetikzlibrary{shapes.geometric, arrows,automata,positioning}
%\RequirePackage{adforn}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\addtodef{\chapter}{%
  \setcounter{secnumdepth}{2}}{}

\renewcommand\memchapstarinfo[2]{%
  \setcounter{secnumdepth}{-1}
  \chaptermark{#1}%
  \if@minitoc\addstarredchapter{#1}\fi}
\if@minitoc\nobibintoc
\nomtcrule
\fi

% \renewcommand\memchapstarinfo[2]{%
%   \setcounter{secnumdepth}{-1}
%   \chaptermark{#1}%
%   \if@minitoc\addstarredchapter{#1}\fi}
% \if@minitoc\nobibintoc\fi

\newcommand{\idx}[1]{\index{#1}#1}

\ifdraftdoc
  \def\cleardoublepage{\clearpage}
  \def\clearforchapter{\clearpage}
\fi

\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}

\def\cite{\expandafter\citep}

\newsubfloat{figure}
\newsubfloat{table}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pied de page pour les versions non finales
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\draftmark}{\theauthor~---~version du \today~(\printtime)}%
\ifdraftdoc
  \makeevenfoot{headings}{\draftmark}{}{}%
  \makeevenfoot{plain}{\draftmark}{}{}%
  \makeoddfoot{headings}{}{}{\draftmark}%
  \makeoddfoot{plain}{}{}{\draftmark}%
  \changemarks%
  \def\warningorerror{\PackageInfo}
\else
  \nochangemarks%
  \def\warningorerror{\PackageWarning}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nouveaux environnements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\myparagraph}[1]{\vspace{0.3\baselineskip}\noindent{\itshape{#1}}}


% \newenvironment{myblock}[1][]{%
%   \begin{mdframed}[%
%     frametitle={#1},
%     frametitlerule=true,
%  		frametitlebackgroundcolor=gray!30,
%     linewidth=0.5pt,
%     skipabove=\baselineskip plus 2pt minus 1pt,
%     skipbelow=\baselineskip plus 2pt minus 1pt]}{\end{mdframed}}

% \newcommand{\voir}{ \fbox{\large$\sphericalangle\!\!\cdot$}}
% \newcommand{\mydraftblock}[1]{%
% 	\medskip\par\noindent%
% 	\begin{boxedminipage}{\columnwidth}#1\end{boxedminipage}%
% 	\marginpar{\ \ \ \voir}{}\medskip}

% % todo
\newlistof{listoftodo}{todolist}{Liste des tâches à faire}
\addtodef{\listoftodo}{\cleardoublepage}{}
\newlistentry{todolistentry}{todolist}{0}
\newcounter{todo}[chapter]
\newcommand{\todo}[1]{%
	\stepcounter{todo}%
	\mydraftblock{\textbf{À faire (\arabic{chapter}.\arabic{todo}) :} \textit{#1}}%
	\addcontentsline{todolist}{todolistentry}{#1}}



      \newcommand{\blankpage}{
        \vfill
        \break
        \begin{vplace}
          \thispagestyle{empty}
          %\hspace{17em}{\fontsize{20}{0}\selectfont\textcolor{customOrange1}{\adforn{21}}}
        \end{vplace}
      }

      \newlength{\myhspace}
      \addtolength{\myhspace}{4em}

      \newcommand\crulefill[1][1ex]{\leavevmode\leaders\hrule depth \dimexpr-#1+0.4pt height #1\hfill\kern0pt}
      \newcommand\ornline[2][1ex]{\trivlist\item\crulefill[#1]{\quad\textcolor{dark-gray}{\textbf{#2}}\quad}\crulefill[#1]\endtrivlist}

      % Contribution list command
      \NewDocumentCommand\synopsis{> {\SplitList{;}} m m}
      {
        % \vspace{-1ex}
        \hspace{\myhspace}\parbox[t]{\hsize-10em}{\ornline{#2}}
        %\hspace{\myhspace}\parbox[t]{\hsize-10em}{\ornline{Contributions}}
        %\renewcommand{\labelitemi}{\textcolor{dark-gray}{\adforn{73}}}
        \vspace{-1.5ex}
        \begin{itemize}
          \setlength\itemsep{1ex}
          \setlength{\itemindent}{\wd\ChpNumBox+1em}
          \ProcessList{#1}{\insertitem}
        \end{itemize}

        % \vspace{2ex}
        %\hspace{17em}{\fontsize{15}{0}\selectfont\textcolor{customOrange1}{\adforn{21}}}
      }
      \newcommand\insertitem[1]{\item\textcolor{dark-gray}{#1}}


% preamble
% \newcommand{\preambleend}{\if@minitoc\minitoc\fi\newpage}
% \newcommand{\preamblestyle}{}%\itshape}
% \newcommand{\preamblebegin}{}
% \newenvironment{preamble}{\preamblebegin\bgroup\preamblestyle\list{}{}\item[]}{\endlist\egroup\preambleend}

\newcommand{\preambleend}{
  \hspace{\myhspace}\parbox[t]{\hsize-10em}{\ornline{Sommaire}}
  % \vspace{-2em}
  \if@minitoc\minitoc\fi}
  % \vspace{-2em}

% \newcommand{\preamblestyle}{\itshape}
\newcommand{\preamblestyle}{}
\newcommand{\preamblebegin}{}

% \newenvironment{preamble}[1]{\preamblebegin\bgroup\preamblestyle\list{}{}\item[]}{\endlist\egroup\preambleend}
\newenvironment{preamble}{\preamblebegin\bgroup\preamblestyle\list{}{}\item[]}{\endlist\egroup}

\newcommand{\chpsummary}[2]{
  % \vspace*{\fill}
  \vspace{-3ex}
  \preambleend
  \vspace{-5ex}
  % \vspace*{\fill}

  \synopsis{#2}{#1}

  % \vspace*{\fill}
  % \vspace{2ex}
  % \hspace{17em}{\fontsize{15}{0}\selectfont\textcolor{customOrange1}{\adforn{21}}}
  \newpage
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nouvelles commandes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\og{``}
\def\fg{''}
\newcommand{\quotes}[1]{\og{#1}\fg}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Style global
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% taille de la page
\oddsidemargin 0.200 in
\evensidemargin 0 in
\marginparsep 0 in
\marginparwidth 0.9 in
\textwidth 6.175 true in

% césure
\tolerance = 1414
\hbadness = 1414
\emergencystretch 1.5em
\hfuzz 0.3pt
\widowpenalty=10000
\vfuzz \hfuzz
\raggedbottom

% bibliographie
\makeindex
\if@minitoc
  \let\OldBibliography=\bibliography
  \renewcommand{\bibliography}[1]{\OldBibliography{#1}\adjustmtc}
\fi
\let\oldbibliographystyle\bibliographystyle
\def\bibliographystyle#1{\def\bibliographystyle##1{}\oldbibliographystyle{#1}}
\AtEndDocument{\bibliographystyle{apalike-fr}}

\def\fonteauteurs{\rm}

% lien
\if@hyperref
  \hypersetup{colorlinks=true,plainpages=false}
  \if@paper
    \hypersetup{urlcolor=black,menucolor=black,filecolor=black,citecolor=black,anchorcolor=black,linkcolor=black}
  \else
    \hypersetup{urlcolor=violet,menucolor=red,filecolor=red,citecolor=blue,anchorcolor=red,linkcolor=blue}
  \fi
\fi

% liste
\newcommand{\NoSpace}{\itemsep=0pt\topsep=0pt\partopsep=0pt\parskip=0pt\parsep=0pt}

% listing
\let\oldlstlistingname=\lstlistingname
\def\lstlistingname{\textsc{\oldlstlistingname}}

% paragraphe
\let\originalparagraph\paragraph
\renewcommand{\paragraph}[2][.]{\originalparagraph{\textit{#2}#1}}

% section
\setcounter{secnumdepth}{2}
\setcounter{maxsecnumdepth}{2}
\if@minitoc \setcounter{minitocdepth}{1}\fi

% table des matières
\setcounter{tocdepth}{2}

\setfloatlocations{figure}{htbp}
\setfloatlocations{lstlistings}{htbp}

% typographie française
\addto\captionsfrench{\def\tablename{Tableau}}
\captiondelim{~:~}

% url
\urlstyle{sf}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Style des chapitres
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newsavebox{\ChpNumBox}
\definecolor{customBlue}{rgb}{0.00,0.65,0.65}
\newcommand*{\thickhrulefill}{%
  \leavevmode\leaders\hrule height 1\p@ \hfill \kern \z@}
\newcommand*\BuildChpNum[2]{%
  \begin{tabular}[t]{@{}c@{}}
    \makebox[0pt][c]{#1\strut}\\[.5ex]
    \colorbox{customBlue}{%
      \rule[-10em]{0pt}{0pt}%
      \rule{1ex}{0pt}\color{black}#2\strut
      \rule{1ex}{0pt}}%
  \end{tabular}}
\makechapterstyle{BlueBox}{%
  \renewcommand{\chapnamefont}{\large\scshape}
  \renewcommand{\chapnumfont}{\Huge\bfseries}
  \renewcommand{\chaptitlefont}{\raggedleft\Huge\bfseries}
  \setlength{\beforechapskip}{20pt}
  \setlength{\midchapskip}{26pt}
  \setlength{\afterchapskip}{40pt}
  \renewcommand{\printchaptername}{}
  \renewcommand{\chapternamenum}{}
  \renewcommand{\printchapternum}{%
    \sbox{\ChpNumBox}{%
      \BuildChpNum{\chapnamefont\@chapapp}%
      {\chapnumfont\thechapter}}}
  \renewcommand{\printchapternonum}{%
    \sbox{\ChpNumBox}{%
      \BuildChpNum{\chapnamefont\vphantom{\@chapapp}}%
      {\chapnumfont\hphantom{\thechapter}}}}
  \renewcommand{\afterchapternum}{}
  \renewcommand{\printchaptertitle}[1]{%
    \usebox{\ChpNumBox}\hfill
    \parbox[t]{\hsize-\wd\ChpNumBox-1em}{%
      \vspace{\midchapskip}%
      \thickhrulefill\par
      {\chaptitlefont ##1\par}}}%
}
\chapterstyle{BlueBox}
\definecolor{light-gray}{gray}{0.6}
\definecolor{dark-gray}{gray}{0.3}

\renewcommand{\printtoctitle}[1]{\begin{flushright}\Huge{#1}\end{flushright}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Style des remerciements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\long\def\thanks#1{\long\def\thesis@thanks{#1}}

\def\thesis@thanks{}

\newcommand\makethanks{
  \chapter*{Remerciements}
  \thesis@thanks
  \clearpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Style du résumé / abstract
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\long\def\abstract#1{\long\def\thesis@abstract{#1}}
\long\def\resume#1{\long\def\thesis@resume{#1}}
\def\keywords#1{\def\thesis@keywords{#1}}
\def\motsclefs#1{\def\thesis@motsclefs{#1}}

\def\thesis@abstract{}
\def\thesis@resume{}
\def\thesis@keywords{}
\def\thesis@motsclefs{}

%\def\abstractstyle#1{\begin{center}\bfseries#1\end{center}\medskip}
\def\keywordsstyle#1{\noindent\textbf{#1} \itshape}
\def\abstractstyle#1{\begin{flushright}\Huge{#1}\end{flushright}}

\newcommand\makeabstract{
  \thispagestyle{empty}
  \enlargethispage{2cm}
  % {
  %   \selectlanguage{english}
  %   \abstractstyle{\abstractname}
  %   {
  %     \small
  %     \par\thesis@abstract
  %     \bigskip\par\keywordsstyle{\keywordsname}
  %     \thesis@keywords
  %   }
  % }
  % \vfill
  % \hrule
  % \bigskip
  {
    \selectlanguage{french}
    \abstractstyle{\resumename}
    {
      \small
      \par\thesis@resume
      \bigskip\par\keywordsstyle{\motsclefsname}
      \thesis@motsclefs
    }
  }
  \vfill
  \begin{minipage}{.96\textwidth}
    \hrule\vspace*{1ex}
    \hfill\centering\mbox{\@laboratoryadresse}\hfill
    \vspace*{1ex}\hrule
  \end{minipage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mise en page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\old@backmatter=\backmatter
\def\backmatter{\old@backmatter\def\backmatter{}}

\let\orig@document=\document
\let\orig@enddocument=\enddocument

\def\content{\memjustarg}
\def\end@content{\orig@enddocument}





\renewenvironment{document}{%
  \orig@document%
  \selectlanguage{french}%
  \maketitle%
  \cleardoublepage%
  \frontmatter%
  \if@minitoc\dominitoc\fi%
  \if@abstract\makeabstract\fi%
  \if@thanks\makethanks\cleardoublepage\fi%
  \tableofcontents\cleardoublepage%
  \if@minitoc\adjustmtc\fi%
  \mainmatter%
  \content\begingroup}{%
  \backmatter%
  \ifdraftdoc%
    \listoftodo\cleardoublepage%
  \else%
    \renewcommand{\todo}[1]{}%
  \fi%
  \if@lof\listoffigures\cleardoublepage\fi%
  \if@lot\listoftables\cleardoublepage\fi%
  \if@lol\lstlistoflistings\cleardoublepage\fi%
  \if@abstract\makeabstract\fi%
  \endgroup\end@content}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput
