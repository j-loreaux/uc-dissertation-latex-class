%% uc-dissertation
%%   LaTeX class for writing Ph.D. theses 
%%   for the University of Cincinnati.
%% Author: Jireh Loreaux <loreaujy@gmail.com>
%%
%% This material is subject to the LaTeX Project Public License
%% version 1.3c or, if you prefer, any later version of this license.
%% See http://latex-project.org/lppl/lppl-1-3c.html
%% for the details of that license.
%%
%% Please let me know if you use uc-dissertation.
%% I'll will do my best to implement suggestions assuming they are 
%% appropriate for a LaTeX class.


%% ========================================================================
%% Identification
%% ========================================================================
\newcommand\fileversion{0.9}
\newcommand\filedate{2014/09/03}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uc-dissertation}[\filedate\space University of Cincinnati dissertation class by Jireh Loreaux (v\fileversion)]

%% ========================================================================
%% Option parsing
%% ========================================================================

\DeclareOption{chap}{%
  \AtEndOfClass{%
    \RequirePackage[Lenny]{fncychap}
    \ChNameVar{\usekomafont{title}\Large}
    \ChTitleVar{\usekomafont{title}\Huge}
  }%
}

\DeclareOption{comply}{%
  \PassOptionsToClass{oneside,11pt,toc=listofnumbered}{scrbook}%
  \AtEndOfClass{%
    \let\oldmainmatter\mainmatter%
    \renewcommand\mainmatter{%
      \oldmainmatter%
      \doublespacing%
    }%
    \let\oldbackmatter\backmatter%
    \renewcommand\backmatter{%
      \oldbackmatter%
      \singlespacing%
    }%
    \renewcommand*\mainmattertwo{%
      \if@twoside\cleardoubleoddpage\else\clearpage\fi
      \@mainmattertrue%
      \doublespacing%
    }
  }%
}

\DeclareOption{comply-nospace}{%
  \PassOptionsToClass{oneside,11pt,toc=listofnumbered}{scrbook}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax

%% ========================================================================
%% Package loading
%% ========================================================================

%% Base class
\LoadClass{scrbook}

%% Control structures
\RequirePackage{xifthen}

%% Line spacing
\RequirePackage{setspace}

%% Date manipulations
\RequirePackage{datetime}

%% Complex macro arguments
\RequirePackage{xparse}

%% Graphics management
\RequirePackage{graphicx}

%% General useful tools
\RequirePackage{etoolbox}

%% ========================================================================
%% Main code
%% ========================================================================

%% Counters for loops
\newcounter{LoopCountOne}
\newcounter{LoopCountTwo}

%%% Miscellany 

%% Create a date format using only the month and year (requires 'datetime')
\newdateformat{monthonly}{\monthname[\THEMONTH]{} \THEYEAR}
\renewcommand{\date}[2]{%
  \newdate{fixed}{01}{#1}{#2}
}

%% Makes a mainmatter command that doesn't reset the page numbering
\newcommand*\mainmattertwo{%
  \if@twoside\cleardoubleoddpage\else\clearpage\fi
  \@mainmattertrue%
}

%% Typesets a chapter quote
\DeclareRobustCommand{\chapterquote}[2]{%
  {%
    \singlespacing%
    \begin{minipage}{0.7\textwidth}%
      \noindent\emph{``#1''}%
      \begin{flushright}%
        --- #2%
      \end{flushright}%
    \end{minipage}%
    \vspace{1cm}%
  }%
}

%% Don't break enumerations (etc.) across pages in
%% an ugly manner
\clubpenalty = 10000
\widowpenalty = 10000

%%% Title page macros and user input commands


%% Degree to be conferred
\newcommand*{\@degreetoconfer}{Doctor of Philosophy}
\newcommand*{\degreetoconfer}[1]{%
   \renewcommand{\@degreetoconfer}{#1}
}

%% Department in which degree is earned
\newcommand{\@department}{Mathematical Sciences}
\newcommand{\department}[1]{%
  \renewcommand{\@department}{#1}
}

%% College in which degree is earned
\newcommand*{\@college}{McMicken College of Arts and Sciences}
\newcommand*{\college}[1]{%
  \renewcommand{\@college}{#1}
}

%% University where degree is earned
\newcommand*{\@university}{University of Cincinnati}
\newcommand*{\university}[1]{%
  \renewcommand{\@university}{#1}
}

%% reset the internal \@author command to be empty
\renewcommand{\@author}{}

%% Previous degrees

%% The difficulty in defining this command is that we don't know 
%% how many degrees the author has obtained. To get around this,
%% we use the xparse package to split the arguments at semicolons,
%% and then splice these together in the appropriate way. This is
%% almost certainly not elegant code, but it does what we want.

\newcommand{\@previousdegrees}{}

\newcommand{\printmeornotone}[1]{%
  \ifthenelse{\value{LoopCountOne} = \value{LoopCountTwo}}{%
    \g@addto@macro\@previousdegrees{& #1, }%
  }{%
    \relax%
  }%
  \stepcounter{LoopCountTwo}%
}

\newcommand{\printmeornottwo}[1]{%
  \ifthenelse{\value{LoopCountOne} = \value{LoopCountTwo}}{%
    \g@addto@macro\@previousdegrees{#1, \\}%
  }{%
    \relax%
  }%
  \stepcounter{LoopCountTwo}%
}
  
\newcommand{\printmeornotthree}[1]{%
  \ifthenelse{\value{LoopCountOne} = \value{LoopCountTwo}}{%
    \g@addto@macro\@previousdegrees{& \quad #1 \\}%
  }{%
    \relax%
  }%
  \stepcounter{LoopCountTwo}%
}

\NewDocumentCommand\previousdegrees{O{1} >{\SplitList{;}}m >{\SplitList{;}}m >{\SplitList{;}}m}{%
  \renewcommand{\@previousdegrees}{}%
  \setcounter{LoopCountOne}{0}%
  \whiledo{\value{LoopCountOne} < #1}{%
    \setcounter{LoopCountTwo}{0}%
    \ProcessList{#2}{%
      \printmeornotone 
    }%
    \setcounter{LoopCountTwo}{0}%
    \ProcessList{#3}{%
      \printmeornottwo 
    }%
    \setcounter{LoopCountTwo}{0}%
    \ProcessList{#4}{%
      \printmeornotthree 
    }%
    \stepcounter{LoopCountOne}%
  }%
}

%% Committee chair
\newcommand*{\@chair}{}
\newcommand*{\chair}[1]{%
  \renewcommand{\@chair}{#1}
}

%% Committee members (not including chair)

%% We apply the same techniques as for \previousdegrees
\newcommand{\@committee}{}

\newcommand{\printmeornotfour}[1]{%
  \ifthenelse{\value{LoopCountOne} = \value{LoopCountTwo}}{%
    \g@addto@macro\@committee{&#1\\}%
  }{%
    \relax%
  }%
  \stepcounter{LoopCountTwo}%
}

\NewDocumentCommand\committee{O{1} >{\SplitList{;}}m}{%
  \renewcommand{\@committee}{}%
  \setcounter{LoopCountOne}{0}%
  \whiledo{\value{LoopCountOne} < #1}{%
    \setcounter{LoopCountTwo}{0}%
    \ProcessList{#2}{%
      \printmeornotfour 
    }%
    \stepcounter{LoopCountOne}%
  }%
}

\newcommand{\@logo}{\includegraphics[width=2.9in]{UC_logo-[black]}}
\newcommand{\logo}[2][width=0.5\textwidth]{%
  \renewcommand{\@logo}{\includegraphics[#1]{#2}}
}

%%% New title page design

\renewcommand{\maketitle}[1][]{%
  \begin{titlepage}
    \monthonly
    \begin{center}
      \hrulefill\par \vskip 2em
      {\usekomafont{title}{\huge \@title\par}}%
      \vskip 1em
      {\ifx\@subtitle\@empty\else\usekomafont{subtitle}{\@subtitle\par}\fi}%
      \vskip 2em \hrulefill\par
      \vskip 0.6in
      \@logo
      \vskip 0.6in
      {\usekomafont{publishers}%
        A dissertation submitted in partial fulfillment \\
        of the requirements for the degree of \\
        \@degreetoconfer{} \\
      }
      \vskip 2em
      {\usekomafont{publishers}%
        Department of \@department{} \\
        \@college{} \\
        \@university{}, \ifstrequal{#1}{fixed}{\displaydate{fixed}}{\today} \\
      }      
    \end{center}\par
    \vskip \z@ \@plus4fill
    \begin{minipage}[t][][b]{0.5\textwidth}
      \begin{flushleft}
        \begin{tabular}{ll}%
          \ifdefempty{\@author}{}{%
            \textbf{Author:} & \@author \\
          }
          \ifdefempty{\@previousdegrees}{}{%
            \textbf{Degrees:}  \@previousdegrees
          }
        \end{tabular} 
      \end{flushleft}
    \end{minipage}
    \hfill
    \begin{minipage}[t][][b]{0.5\textwidth}
      \begin{flushleft}
        \begin{tabular}{ll}
            \ifdefempty{\@chair}{}{%
              \textbf{Chair:} & \@chair \\
            }
            \ifdefempty{\@committee}{}{%
              \textbf{Committee:}  \@committee
            }
        \end{tabular}
      \end{flushleft}
    \end{minipage}
    \usdate
  \end{titlepage}
}

%%% Abstract

\newcommand{\@abstract}{}
\newcommand{\abstract}[1]{%
  \renewcommand{\@abstract}{#1}
}

\newcommand{\abstractpage}{%
  \cleardoublepage
  \chapter{Abstract}
  \label{cha:abstract}
  \pagestyle{plain}
  \@abstract
}

%%% Copyright page

\newcommand{\copyrightpage}[1][all]{%
  \cleardoublepage
  \thispagestyle{empty}
  \ifthenelse{\isempty{#1}}{\hfill\par}{%
    \hfill\par%
    \vskip 0.33\textheight%
    \begin{center}
      {%
        \usekomafont{publishers}{%
          \addcontentsline{toc}{chapter}{Copyright}%
          \copyright{} \the\year{} by \@author.%
          \ifthenelse{\equal{all}{#1}}{ All rights reserved.}{} \par
          \vskip 1em \par
          \ifthenelse{\isin{cc}{#1}}{%
            {Released under a Creative Commons \par}%
          }{}
          \ifthenelse{\isin{by}{#1}}{%
            {Attribution--}%
          }{}%
          \ifthenelse{\isin{nc}{#1}}{%
            {NonCommercial--}%
          }{}%
          \ifthenelse{\isin{nd}{#1}}{%
            {NoDerivatives \par
              4.0 International License.
            }%
          }{}%
          \ifthenelse{\isin{sa}{#1}}{%
            {ShareAlike \par
              4.0 International License.
            }%
          }{}%
          \vskip 2em \par
          \ifthenelse{\isin{cc}{#1}}{%
            \includegraphics[width=0.75cm]{cc}
          }{}
          \ifthenelse{\isin{by}{#1}}{%
            \includegraphics[width=0.75cm]{by}
          }{}
          \ifthenelse{\isin{nc}{#1}}{%
            \includegraphics[width=0.75cm]{nc}
          }{}
          \ifthenelse{\isin{nd}{#1}}{%
            \includegraphics[width=0.75cm]{nd}
          }{}%
          \ifthenelse{\isin{sa}{#1}}{%
            \includegraphics[width=0.75cm]{sa}
          }{}
        }%
      }%
    \end{center}
  }%
}

%%% Acknowledgments

\newcommand{\@acknowledgments}{}
\newcommand{\acknowledgments}[1]{%
  \renewcommand{\@acknowledgments}{#1}
}

\newcommand{\acknowledgmentspage}{%
  \cleardoublepage
  \chapter{Acknowledgments}
  \label{cha:acknowledgments}
  \pagestyle{plain}
  \@acknowledgments
}

