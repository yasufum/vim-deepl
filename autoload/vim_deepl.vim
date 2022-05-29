function! vim_deepl#Echo() abort
    echo "call vim_deepl#Echo!"
endfunction

" Return abbr term of language.
" https://www.deepl.com/ja/docs-api/translating-text/
function! s:getLangTerm(term)
    let l:langMap = {
                \'BG':'Bulgarian',
                \'CS':'Czech',
                \'DA':'Danish',
                \'DE':'German',
                \'EL':'Greek',
                \'EN':'English',
                \'ES':'Spanish',
                \'ET':'Estonian',
                \'FI':'Finnish',
                \'FR':'French',
                \'HU':'Hungarian',
                \'ID':'Indonesian',
                \'IT':'Italian',
                \'JA':'Japanese',
                \'LT':'Lithuanian',
                \'LV':'Latvian',
                \'NL':'Dutch',
                \'PL':'Polish',
                \'PT':'Portuguese',
                \'RO':'Romanian',
                \'RU':'Russian',
                \'SK':'Slovak',
                \'SL':'Slovenian',
                \'SV':'Swedish',
                \'TR':'Turkish',
                \'ZH':'Chinese'
                \}

    let ls = keys(l:langMap)
    for k in ls
        if k == a:term
            return k
        elseif l:langMap[k] == a:term
            return k
        endif
    endfor
    return ''
endfunction

" Translage given term
function! s:translate(...) abort
    let l:defaultSrc = 'EN'
    let l:defaultTgt = 'JA'

    let l:text = a:1

    let l:src = s:getLangTerm(a:2)
    let l:tgt = s:getLangTerm(a:3)

    let l:sourceLang = l:src != '' ? l:src : l:defaultSrc
    let l:targetLang = l:tgt != '' ? l:tgt : l:defaultTgt

    let l:dlUrl = g:vim_deepl#endpoint
                \. ' -d auth_key='.g:vim_deepl#authkey
                \. ' -d "text='.l:text.'"'
                \. ' -d "target_lang='.l:targetLang.'"'
                \. ' -d "source_lang='.l:sourceLang.'"'
    let l:cmd = 'curl -X GET '.l:dlUrl
    "let l:res = system(l:cmd)
    "return l:res
    return l:cmd
endfunction

" Main
function! vim_deepl#Main(...) abort
    let l:res = s:translate(a:1, a:2, a:3)
    "let l:res = s:translate(a:1, 'JA', 'EN')
    echo l:res
    "echo 'a1:'.a:1.', a2:'.a:2.', a3:'.a:3
endfunction

" tmp function for test
function! vim_deepl#ValidLang(term) abort
    echo s:getLangTerm(a:term)
endfunction
