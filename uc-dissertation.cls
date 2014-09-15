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
\newcommand\fileversion{0.2.9}
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

%% Committee chair
\newcommand*{\@chair}{}
\newcommand*{\chair}[1]{%
  \renewcommand{\@chair}{#1}
}

