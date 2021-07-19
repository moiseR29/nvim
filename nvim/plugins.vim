call plug#begin('~/.vim/plugged')

" Git Integration
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
" Plug 'tpope/vim-rhubarb'

" Themes 
Plug 'ayu-theme/ayu-vim'
"Plug 'morhetz/gruvbox'
"Plug 'joshdick/onedark.vim'
"Plug 'mhartington/oceanic-next'

" Syntax
Plug 'yggdroot/indentline'
Plug 'sheerun/vim-polyglot'
"Plug 'leafgarland/typescript-vim'
"Plug 'pangloss/vim-javascript'
"Plug 'HerringtonDarkholme/yats.vim'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" snippets
"Plug 'sirver/ultisnips'

" python
" Plug 'davidhalter/jedi-vim'

" IDE
Plug 'neoclide/coc.nvim', {'branch':'release'}
"Plug 'lilydjwg/colorizer'
"Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ddollar/nerdcommenter'
"Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
"Plug 'honza/vim-snippets'

" Multicursor
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }

" Navigate
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
" Plug 'easymotion/vim-easymotion'

" Bar
Plug 'itchyny/lightline.vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

call plug#end()
