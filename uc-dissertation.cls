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
\newcommand\fileversion{0.4}
\newcommand\filedate{2014/09/03}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uc-dissertation}[\filedate\space University of Cincinnati dissertation class by Jireh Loreaux (v\fileversion)]

%% ========================================================================
%% Option parsing
%% ========================================================================


\DeclareOption{comply}{%
  \PassOptionsToClass{oneside,11pt,toc=listofnumbered,toc=bibnumbered}{scrbook}
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

\newcommand{\@logo}{\includegraphics[width=0.5\textwidth]{UC_logo-[black]}}
\newcommand{\logo}[2][width=0.5\textwidth]{%
  \renewcommand{\@logo}{\includegraphics[#1]{#2}}
}

%%% New title page design

\renewcommand{\maketitle}[1][0em]{%
  \begin{titlepage}
    \begin{center}
      \hrulefill\par \vskip 2em
      {\usekomafont{title}{\huge \@title\par}}%
      \vskip 1em
      {\ifx\@subtitle\@empty\else\usekomafont{subtitle}{\@subtitle\par}\fi}%
      \vskip 2em \hrulefill\par
      \vskip \z@ \@plus4fill
      \@logo
      \vskip \z@ \@plus4fill
      {\usekomafont{publishers}%
        A dissertation submitted in partial fulfillment \\
        of the requirements for the degree of \\
        \@degreetoconfer{} \\
      }
      \vskip 2em
      {\usekomafont{publishers}%
        Department of \@department{} \\
        \@college{} \\
        \@university{}, \the\year{} \\
      }      
    \end{center}\par
    \vskip \z@ \@plus4fill
    \begin{minipage}[t][][b]{0.5\textwidth}
      \begin{flushleft}
        \begin{tabular}{ll}%
          \ifdefempty{\@author}{}{%
            \textbf{Author:} & \@author \\[#1]
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
              \textbf{Chair:} & \@chair \\[#1]
            }
            \ifdefempty{\@committee}{}{%
              \textbf{Committee:}  \@committee
            }
        \end{tabular}
      \end{flushleft}
    \end{minipage}
  \end{titlepage}
}
