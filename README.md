# yasufum/vim-deepl

Deepl client plugin for vim.

## Settings for Deepl

You should set endpoint and authkey as environment variables.
The value of endpoint can be defined for free or pro account which is depends
on your plan. You can find your authkey in
[your account page](https://www.deepl.com/ja/account).

```sh
# $HOME/.bashrc`
DEEPL_ENDPOINT=https://api-free.deepl.com/v2/translate
DEEPL_AUTHKEY=[YOUR_AUTHKEY]
```

## How to Use

You call functions from command line buffer, or set key map.
Here is a list of functions provided in this plugin.

1. Deepl: Translate selected region in **visual mode**.
2. DeeplOnCursor: Translate a term on which cursor is in **normal mode**.
3. DeeplTerm: Translate given term.

For `DeeplTerm`, it takes additional arguments, names or its short terms of
source and target language. For instance, it translate Japanese word
`こんにちは` to German `Guten Tag`.

```
" Given word with short terms of languages.
:DeeplTerm こんにちは JA DE

" Given word with names of languages.
:DeeplTerm こんにちは Japanese German
```

## Configuration

It's better to setup keymaps for  `DeeplOnCursor` and `Deepl`.
`t` is for translation.

```
nnoremap <Leader>t :DeeplOnCursor<CR>
vnoremap <Leader>t :Deepl<CR>
```
