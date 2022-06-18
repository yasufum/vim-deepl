" Skip loading again if it's already loaded.                                        
if exists("g:vim_deepl")                                              
  finish                                                                            
endif                                                                               
let g:vim_deepl= 1

let g:vim_deepl#endpoint='https://api-free.deepl.com/v2/translate'
let g:vim_deepl#authkey=$DEEPL_AUTHKEY

command! -range=% Deepl call vim_deepl#Main()
command! DeeplOnCursor call vim_deepl#SearchOnCursor()
command! -nargs=1 DeeplTestValidLang call vim_deepl#ValidLang(<f-args>)
command! -nargs=* DeeplTerm call vim_deepl#Term(<f-args>)

"nnoremap <Leader>t :DeeplOnCursor<CR>
"vnoremap <Leader>t :Deepl<CR>
