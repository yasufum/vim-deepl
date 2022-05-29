" Skip loading again if it's already loaded.                                        
if exists("g:vim_deepl")                                              
  finish                                                                            
endif                                                                               
let g:vim_deepl= 1

command! -nargs=0 DeeplEcho call vim_deepl#Echo()
command! -nargs=1 DeeplTerm call vim_deepl#ValidLang(<f-args>)
command! -nargs=* Deepl call vim_deepl#Main(<f-args>)
