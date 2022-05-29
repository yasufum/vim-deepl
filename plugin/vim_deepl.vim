" Skip loading again if it's already loaded.                                        
if exists("g:vim_deepl")                                              
  finish                                                                            
endif                                                                               
let g:vim_deepl= 1

command! -nargs=0 DeeplEcho call vim_deepl#Echo()
command! -nargs=0 Deepl call vim_deepl#Main()
