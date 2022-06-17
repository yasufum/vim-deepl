" Skip loading again if it's already loaded.                                        
if exists("g:vim_deepl")                                              
  finish                                                                            
endif                                                                               
let g:vim_deepl= 1

command! -range=% Deepl call vim_deepl#Main()
command! -nargs=1 DeeplTestValidLang call vim_deepl#ValidLang(<f-args>)
command! -nargs=* DeeplTerm call vim_deepl#Term(<f-args>)
