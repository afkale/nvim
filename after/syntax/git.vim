" Extra highlighting for human-readable `git blame` output (the format used by
" mini.git's `:Git blame`). The runtime syntax/git.vim only handles porcelain
" blame headers, so color the default format here:
"   <sha> (<author> <date> <lineno>) <text>
" `gitBlameSha` wins over the runtime `gitHashAbbrev` (later definition = higher
" priority at the same position) and hands over to `gitBlameMeta` via nextgroup,
" otherwise the region would never start (the hash match starts earlier in the
" line and would starve a line-anchored region).
syn match gitBlameSha /^\s*\^\?\x\{7,\}/ nextgroup=gitBlameMeta skipwhite
syn region gitBlameMeta start=/(/ end=/)/ oneline keepend contained contains=gitBlameLineNo,gitBlameAuthor,gitBlameDate
syn match gitBlameLineNo /\d\+/ contained
syn match gitBlameAuthor /[^()]\{-}\ze\s\d\{4}-\d\d-\d\d\s/ contained
syn match gitBlameDate /\d\{4}-\d\d-\d\d \d\d:\d\d:\d\d [+-]\d\{4}/ contained

hi def link gitBlameSha Identifier
hi def link gitBlameMeta Delimiter
hi def link gitBlameAuthor Title
hi def link gitBlameDate Number
hi def link gitBlameLineNo Comment
