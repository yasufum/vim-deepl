if g:vim_deepl#srcLang == ''
    let s:defaultSrc = 'EN'
else
    let s:defaultSrc = g:vim_deepl#srcLang
end

if g:vim_deepl#tgtLang == ''
    let s:defaultTgt = 'JA'
else
    let s:defaultTgt = g:vim_deepl#tgtLang
end

let s:langMap = {
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

function! vim_deepl#Main() abort
    " Get selected region in visual mode.
    let tmp = @@
    silent normal gvy
    let selected = @@
    let @@ = tmp

    let l:res = s:translate(selected, s:defaultSrc, s:defaultTgt)
    echo l:res
endfunction

function! vim_deepl#SearchOnCursor() abort
    let l:word = expand("<cword>")
    let l:res = s:translate(l:word, s:defaultSrc, s:defaultTgt)
    echo l:res
endfunction

" Return abbr term of language.
function! s:getAbbrTerm(term) abort
    let ks = keys(s:langMap)
    for k in ks
        if k == a:term
            return k
        elseif s:langMap[k] == a:term
            return k
        endif
    endfor
endfunction

" Show all supported languages, or each name or its abbreviation form of given
" term.
" https://www.deepl.com/ja/docs-api/translating-text/
function! s:langTerm(...) abort
    if a:0 == 0
        let ks = keys(s:langMap)
        let l:res = ""
        for k in ks
            let l:res = l:res . k . ": " . s:langMap[k] . "\n"
        endfor
        let l:res = l:res[0:-2]
        return l:res
    else
        let ks = keys(s:langMap)
        for k in ks
            if k == a:1
                return s:langMap[k]
            elseif s:langMap[k] == a:1
                return k
            endif
        endfor
    end
    return ''
endfunction

" Translage given term
function! s:translate(...) abort
    " Check your authkey first.
    if g:vim_deepl#authkey == ''
        echo 'Error: You should set $DEEPL_AUTHKEY for your deepl auth key!'
        return ''
    endif

    " Replace backquotes to avoid enclosed terms are run as a command.
    let l:text = substitute(a:1, '`', "'", 'g')
    " Replace double quotes which are dropped while parsing with jq.
    let l:text = substitute(l:text, '"', "'", 'g')
    let l:src = s:getAbbrTerm(a:2)
    let l:tgt = s:getAbbrTerm(a:3)

    let l:dlUrl = g:vim_deepl#endpoint
                \. ' --silent'
                \. ' -d auth_key='.g:vim_deepl#authkey
                \. ' -d "text='.l:text.'"'
                \. ' -d "source_lang='.l:src.'"'
                \. ' -d "target_lang='.l:tgt.'"'
    let l:cmd = 'curl -X GET '.l:dlUrl.' | jq .translations[0].text'

    " Remove newline
    let l:res = system(l:cmd)[:-2]

    return l:res
endfunction

" Main
function! vim_deepl#Term(...) abort
    if a:0 == 1
        let l:srcLang = s:defaultSrc
        let l:tgtLang = s:defaultTgt
    elseif a:0 == 2
        let l:srcLang = a:2
        let l:tgtLang = s:defaultTgt
    elseif a:0 == 3
        let l:srcLang = a:2
        let l:tgtLang = a:3
    end

    let l:res = s:translate(a:1, l:srcLang, l:tgtLang)

    echo l:res
endfunction

" tmp function for test
function! vim_deepl#ShowLang(...) abort
    if a:0 == 0
        echo s:langTerm()
    else
        echo s:langTerm(a:1)
    end
endfunction
