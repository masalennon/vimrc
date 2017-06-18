if has('vim_starting')
    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " NeoBundleが未インストールであればgit cloneする・・・・・・①
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif
call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするVimプラグインを以下に記述
" NeoBundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
"----------------------------------------------------------
" ここに追加したいVimプラグインを記述する・・・・・・②
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kana/vim-submode'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'b4b4r07/vim-shellutils'







"----------------------------------------------------------
" 未インストールのVimプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定・・・・・・③
NeoBundleCheck
call neobundle#end()






"-------基本設定--------
"タイトルをバッファ名に変更しない
set notitle
set shortmess+=I

"ターミナル接続を高速にする
set ttyfast

"ターミナルで256色表示を使う
set t_Co=256

if has ("viminfo")
"フォールド設定(未使用)
"set foldmethod=indent
set foldmethod=manual
"set foldopen=all
"set foldclose=all
endif

"VIM互換にしない
set nocompatible

"複数ファイルの編集を可能にする
set hidden

"内容が変更されたら自動的に再読み込み
set autoread

"Swapを作るまでの時間m秒
set updatetime=0

"Unicodeで行末が変になる問題を解決
set ambiwidth=double

"行間をでシームレスに移動する
set whichwrap+=h,l,<,>,[,],b,s

"カーソルを常に画面の中央に表示させる
"set scrolloff=999

"バックスペースキーで行頭を削除する
set backspace=indent,eol,start

"カッコを閉じたとき対応するカッコに一時的に移動
set nostartofline

"C-X,C-Aを強制的に10進数認識させる
set nrformats=
"set nrformats=alpha
"行末まで検索したら行頭に戻る
set wrapscan

"-------Format--------
"自動インデントを有効化する
set smartindent
set autoindent

"フォーマット揃えをコメント以外有効にする
set formatoptions-=c

"括弧の対応をハイライト
set showmatch

"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab

"ターミナル上からの張り付けを許可
set paste

"http://peace-pipe.blogspot.com/2006/05/vimrc-vim.html
set tabstop=4
set shiftwidth=2
set softtabstop=0
set expandtab
"検索結果をハイライトする
set hlsearch

"ルーラー,行番号を表示
set ruler
set number

"コマンドラインの高さ
set cmdheight=1

"マクロなどの途中経過を描写しない
set lazyredraw

"カーソルラインを表示する
set cursorline

"ウインドウタイトルを設定する
set title
"titleを変更しない
set notitle

"コマンドラインでTABで補完できるようにする
set wildchar=<C-Z>

"改行後に「Backspace」キーを押すと上行末尾の文字を1文字消す
set backspace=2

"C-vの矩形選択で行末より後ろもカーソルを置ける
set virtualedit=block

"コマンド、検索パターンを50まで保存
set history=50

"履歴に保存する各種設定
set viminfo='100,/50,%,<1000,f50,s100,:100,c,h,!

"バックアップを作成しない
set nobackup

"-------Search--------
"インクリメンタルサーチを有効にする
set incsearch

"大文字小文字を区別しない
set ignorecase

"大文字で検索されたら対象を大文字限定にする
"検索結果をハイライトする
set hlsearch

"ルーラー,行番号を表示
set ruler
set number

"コマンドラインの高さ
set cmdheight=1

"マクロなどの途中経過を描写しない
set lazyredraw

"カーソルラインを表示する
set cursorline

"ウインドウタイトルを設定する
set title

"自動文字数カウント
augroup WordCount
    autocmd!
    autocmd BufWinEnter,InsertLeave,CursorHold * call WordCount('char')
augroup END
let s:WordCountStr = ''
let s:WordCountDict = {'word': 2, 'char': 3, 'byte': 4}
function! WordCount(...)
    if a:0 == 0
        return s:WordCountStr
    endif
    let cidx = 3
    silent! let cidx = s:WordCountDict[a:1]
    let s:WordCountStr = ''
    let s:saved_status = v:statusmsg
    exec "silent normal! g\<c-g>"
    if v:statusmsg !~ '^--'
        let str = ''
        silent! let str = split(v:statusmsg, ';')[cidx]
        let cur = str2nr(matchstr(str, '\d\+'))
        let end = str2nr(matchstr(str, '\d\+\s*$'))
        if a:1 == 'char'
            " ここで(改行コード数*改行コードサイズ)を'g<C-g>'の文字数から引く
            let cr = &ff == 'dos' ? 2 : 1
            let cur -= cr * (line('.') - 1)
            let end -= cr * line('$')
        endif
        let s:WordCountStr = printf('%d/%d', cur, end)
    endif
    let v:statusmsg = s:saved_status
    return s:WordCountStr
endfunction



set clipboard+=unnamed
"ステータスラインにコマンドを表示
set showcmd
"ステータスラインを常に表示
set laststatus=2
"ファイルナンバー表示
set statusline=[%n]
"ホスト名表示
set statusline+=%{matchstr(hostname(),'\\w\\+')}@
"ファイル名表示
set statusline+=%<%F
"変更のチェック表示
set statusline+=%m
"読み込み専用かどうか表示
set statusline+=%r
"ヘルプページなら[HELP]と表示
set statusline+=%h
"プレビューウインドウなら[Prevew]と表示
set statusline+=%w
"ファイルフォーマット表示
set statusline+=[%{&fileformat}]
"文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
"ファイルタイプ表示
set statusline+=%y
"ここからツールバー右側
set statusline+=%=
"skk.vimの状態
set statusline+=%{exists('*SkkGetModeStr')?SkkGetModeStr():''}
"文字バイト数/カラム番号
set statusline+=[%{col('.')-1}=ASCII=%B,HEX=%c]
"現在文字列/全体列表示
set statusline+=[C=%c/%{col('$')-1}]
"現在文字行/全体行表示
set statusline+=[L=%l/%L]
"現在のファイルの文字数をカウント
set statusline+=[WC=%{exists('*WordCount')?WordCount():[]}]
"現在行が全体行の何%目か表示
set statusline+=[%p%%]
"レジスタの中身を表示
"set statusline+=[RG=\"%{getreg()}\"]
autocmd InsertLeave * set nopaste
autocmd BufRead * set nopaste
"-------エンコード------
"エンコード設定
if has('unix')
    set fileformat=unix
    set fileformats=unix,dos,mac
    set fileencoding=utf-8
    set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
    set termencoding=utf-8
elseif has('win32')
    set fileformat=dos
    set fileformats=dos,unix,mac
    set fileencoding=utf-8
    set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
    set termencoding=utf-8
endif

"ファイルタイプに応じて挙動,色を変える
syntax on
filetype plugin on
filetype indent on

"-------キー設定-------
"矢印キーでは表示行単位で行移動する
nmap <UP> gk
nmap <DOWN> gj
vmap <UP> gk
vmap <DOWN> gj
nmap k gk
nmap j gj
imap jk <Esc>
"他のvimにviminfoを送る
"http://nanasi.jp/articles/howto/editing/rviminfo.html
nmap ,vw :vw<CR>
nmap ,vr :vr<CR>

"ZZは強制的に書き込む
map ZZ :wq!<CR>

"C-Lでawkを呼び出す
nmap <C-C><C-L> :w !awk 'BEGIN{n=0}{n+=$1}END{print n}'

"C-P,C-Nでバッファ移動,C-Dでバッファ消去
nmap <C-P> :bp<CR>
nmap <C-N> :bn<CR>
"nmap <C-D> :bd<CR>

"C-Nで新しいバッファを開く
nmap <C-C><C-N> :new<CR>

"C-L,C-Lでバッファリスト
nmap <C-L><C-L> :ls<CR>
"C-L,C-Rでレジスタリスト
nmap <C-L><C-R> :dis<CR>
"C-L,C-Kでキーマップリスト
nmap <C-L><C-K> :map<CR>
"C-L,C-Mでマークリ:スト
nmap <C-L><C-M> :marks<CR>
"C-L,C-Jでジャンプリスト
nmap <C-L><C-J> :jumps<CR>
"C-L,C-Hでコマンドヒストリ
nmap <C-L><C-H> :his<CR>
"C-L,C-Uでアンドゥヒストリ
nmap <C-L><C-U> :undolist<CR>

"C-W,sで横分割
nmap <C-W>s :sp<CR>
"C-W,vで縦分割
nmap <C-W>v :vsp<CR>

set smartcase
colorscheme petrel

nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
nnoremap i a
nnoremap a i
nnoremap 0 $
nnoremap 4 0
nnoremap <silent> い i 
nnoremap <Down> gj
nnoremap <Up>   gk




call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')


nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on


"set transparency=20 
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }
inoremap <silent> jk <ESC>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>


autocmd InsertLeave * set nopaste 

