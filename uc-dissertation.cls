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
\newcommand\fileversion{0.1.1}
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