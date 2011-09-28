" Vim syntax file
" Language:	Scribble (a racket language)
" Last Change:	2011-09-28
" Author:	Tim Brown <tim.brown@timb.net>
" Revision:      $Revision: 1.1 $
"
" Suggestions and bug reports (and fixes!) are solicited by the author.
"
" This syntax includes scheme.vim (via racket.vim), and therefore I am
" grateful to those that have worked on this.
"
" Issues:
" * I'm not having much luck with syntax.vim/filetype.vim/scripts.vim in
"   recoginsing a scribble file. However a "vi..m:" modeline does the trick
"   for me now
" * Not supporting vim verisons < 7. If it's simple enough to do, send me a
"   patch
" * @foo|{...}| nesting isn't supported. Again, I don't need it *so* much --
"   and if I were to handle *that* then the next step up to arbitrary
"   @foo|<<<{...}>>>| expressions is just a bit too scary for me!

" Initializing:
if version < 700
  syntax clear
  finish
elseif exists("b:current_syntax")
  finish
endif

" Scribble is a racket language, is mzscheme... so we set this anyway
let is_mzscheme=1
syntax include @SchemeBase syntax/racket.vim

" Because the @ is an "iskeyword" character (and I don't want to change this
" so much)
" "@" (which is itself a keyword character).
syntax keyword scribbleMarkup @chunk @title nextgroup=atBraceRange,atBrackRange
syntax keyword scribbleMarkup @section @subsection @subsubsection nextgroup=atBraceRange,atBrackRange
syntax keyword scribbleMarkup @racket @var @literal @tt @emph nextgroup=atBraceRange,atBrackRange

"syntax region atParenRange matchgroup=Delimiter start="(" end=")" contains=@SchemeBase,atExprStart,scribbleMarkup contained
syntax region atBrackRange matchgroup=Delimiter start="\[" end="\]" contains=@SchemeBase,atExprStart,scribbleMarkup contained nextgroup=atBraceRange
syntax region atBraceRange matchgroup=Delimiter start="{" end="}" contains=atExprStart,atInnerBraceRange,scribbleMarkup contained
syntax region atInnerBraceRange matchgroup=atBraceRange start="{" end="}" contains=atExprStart,atInnerBraceRange,scribbleMarkup contained

syntax match atIdentifier /[-<a-z!$%&*\/:<=>?^_~0-9+.@>]\+/ nextgroup=atBraceRange,atBrackRange contained

syntax match atExprStart "@" nextgroup=atBrackRange,atBraceRange,atIdentifier,@SchemeBase containedin=atBraceRange,atInnerBraceRange,@SchemeBase

" scheme itself is ignored in atBraces

command -nargs=+ HiLink highlight def link <args>
HiLink atBraceRange      String
HiLink atInnerBraceRange String
HiLink atExprStart       Delimiter
HiLink scribbleMarkup    Delimiter
delcommand HiLink

let b:current_syntax = "scribble"
" vim: ts=8
