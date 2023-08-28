" mediatek specific vim settings

packadd matchit
augroup matchit_group
  autocmd!
  autocmd FileType csasm let b:match_words = '\(#block\|#if\):#elif:#else:\(#end\|#endif\)'
augroup END

