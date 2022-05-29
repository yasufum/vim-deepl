function! vim_deepl#Echo() abort
    echo "call vim_deepl#Echo!"
endfunction

function! vim_deepl#Main() abort
    let l:text = 'funnel'
    let l:lang = 'JA'
    let l:dl_url = g:vim_deepl#endpoint
                \. ' -d auth_key='.g:vim_deepl#authkey
                \. ' -d "text='.l:text.'"'
                \. ' -d "target_lang='.l:lang.'"'
    let l:cmd = 'curl -X GET '.l:dl_url
    let l:res = system(l:cmd)
    echo l:res
endfunction
