function! vim_deepl#Main() abort
    " Get selected region in visual mode.
    let tmp = @@
    silent normal gvy
    let selected = @@
    let @@ = tmp

    let l:res = s:translate(selected, 'EN', 'JA')
    echo l:res
endfunction

function! vim_deepl#SearchOnCursor() abort
    let l:word = expand("<cword>")
    let l:res = s:translate(l:word, 'EN', 'JA')
    echo l:res
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
    let l:text = a:1
    let l:src = s:getLangTerm(a:2)
    let l:tgt = s:getLangTerm(a:3)

    let l:dlUrl = g:vim_deepl#endpoint
                \. ' -d auth_key='.g:vim_deepl#authkey
                \. ' -d "text='.l:text.'"'
                \. ' -d "source_lang='.l:src.'"'
                \. ' -d "target_lang='.l:tgt.'"'
    let l:cmd = 'curl -X GET '.l:dlUrl
    let l:res = system(l:cmd)
    return l:res
endfunction

" Main
function! vim_deepl#Term(...) abort
    let l:defaultSrc = 'EN'
    let l:defaultTgt = 'JA'

    if a:0 == 1
        let l:srcLang = l:defaultSrc
        let l:tgtLang = l:defaultTgt
    elseif a:0 == 2
        let l:srcLang = a:2
        let l:tgtLang = l:defaultTgt
    elseif a:0 == 3
        let l:srcLang = a:2
        let l:tgtLang = a:3
    end

    let l:res = s:translate(a:1, l:srcLang, l:tgtLang)

    echo l:res
endfunction

" tmp function for test
function! vim_deepl#ValidLang(term) abort
    echo s:getLangTerm(a:term)
endfunction
