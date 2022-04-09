title: It's a Unix System 
date: 2020-09-13
description: I know this!

# Setup Dev Workflow

Hi I'm going to go through my customized dev environment and linux workflow (?),

this is mostly for starcraft brood war ofc born of necessity. 

I use vim but I expect autocomplete and go to definitions and a tool that let me move throuth my projet easy and quick

is a great text editor available everywhere that let me customize it to my own needs

I'm by no means a vim expert, this is more like my notes in the continuous process of learning and making my own customized experience.

vim window movements suck by default, I need good movements (explain what does this means).

my goals are built-in language support for Python, Lua, Erlang and C 

avoid the requirement of tools outside those supported languages,

avoid rust or go utilities if possible,

avoid c++ if possible,

introduce debian linux

kek

introduce the starcraft and vim comparation..

- vim plugging manager
- my list of pluggins
- autocompletion
- unit tests
- git integration
- startify menu (?)
- go to definition
- linting (?)
- denite (more than just a fuzzy finder!)
- undotree F5
- dirvish (file finder)
- hotkeys

- mksh
- kitty
- bspwm
- tmux

direction is more important than speed

### plug

plug vim pluging manager


### my list of pluggins

| pluggin              | description                                                                 |
| - | - |
| vim-sensible         | a universal set of defaults that everyone can agree on.                     |
| vim-eunuch           | Vim sugar for the UNIX shell commands that need it the most.                |
| vim-fugitive         | It's so awesome, it should be illegal.                                      |
| vim-unimpaired       | Complementary pairs of mappings.                                            |
| vim-repeat           | Repeat.vim remaps . in a way that plugins can tap into it.                  |
| vim-dispatch         | Kick off builds and test suites using one of several asynchronous adapters. |
| vim-startify         | A fancy start screen for Vim                                                |
| vim-signify          | Show differences with style                                                 |
| vim-polyglot         | A solid language pack for Vim.                                              |
| vim-maximizer        | Maximizes and restores the current window in Vim.                           |
| vim-bbye             | Close and remove the buffer.                                                |
| vim-lastplace        | Intelligently reopen files at your last edit position.                      |
| vim-sandwich         | add/delete/replace surroundings of a sandwiched textobject                  |
| vim-highlightedyank  | Make the yanked region apparent!                                            |
| goyo                 | Distraction-free writing in Vim.                                            |
| limelight            | Hyperfocus-writing in Vim.                                                  |
| vim-peekaboo         | see the contents of the registers.                                          |
| vim-easy-align       | A simple, easy-to-use Vim alignment plugin.                                 |
| gv.vim               | A git commit browser in Vim                                                 |
| vim-slash            | Enhancing in-buffer search experience                                       |
| Vim-Jinja2-Syntax    | An up-to-date jinja2 syntax file.                                           |
| denite               | Denite is a dark powered plugin to unite all interfaces.                    |
| vim-dirvish          | Directory viewer for Vim                                                    |
| vim-dirvish-git      | Plugin for dirvish.vim that shows git status flags                          |
| vim-gtfo             | Go to Terminal or File manager                                              |
| vim-love-docs        | Vim plugin for LÖVE syntax highlighting and help file                       |
| vim-pandoc           | pandoc integration and utilities for vim                                    |
| vim-pandoc-syntax    | pandoc markdown syntax                                                      |
| vim-sxhkdrc          | Vim syntax for sxhkd's configuration files                    |
| jupytext.vim         | editing Jupyter ipynb files via jupytext                      |
| tmux-complete.vim    | insert mode completion of words in adjacent tmux panes        |
| vim-tmux-navigator   | Seamless navigation between tmux panes and vim splits         |
| vim-table-mode       | VIM Table Mode for instant table creation.                    |
| auto-pairs           | Vim plugin, insert or delete brackets, parens, quotes in pair |
| undotree             | The undo history visualizer for VIM                           |
| onehalf              | one half dark                                                 |
| rainbow              | Rainbow Parentheses Improved                                  |
| VimCompletesMe       | You don't Complete Me; Vim Completes Me!                      |
| deoplete             | Dark powered asynchronous completion framework for Vim        |
| neoinclude           | Include completion framework for deoplete                     |
| deoplete-clangx      | C/C++ Completion for deoplete using clang                     |
| nvim-yarp            | Yet Another Remote Plugin Framework                           |
| vim-hug-neovim-rpc   | Compatibility layer for neovim rpc client working on vim8     |
| deoplete-vim-lsp     | deoplete source for vim-lsp                                   |
| vim-cmake            | plugin for working with CMake projects                        |
| vim-gutentags        | A Vim plugin that manages your tag files                      |
| tagbar               | displays tags in a window, ordered by scope                   |
| async.vim            | normalize async job control api for vim                       |
| vim-lsp              | async language server protocol plugin for vim                 |
| ale                  | Check syntax in Vim asynchronously and fix files              |
| vim-lsp-ale          | Bridge between vim-lsp and ALE                                |
| neoformat            | A vim plugin for formatting code.                             |
| vim-devicons         | Adds file type icons to Vim plugins                           |
| lightline.vim        | A light and configurable statusline/tabline plugin for Vim    |
| vim-cursorworld      | Underlines the word under the cursor                          |
| lightline-bufferline | bufferline functionality for the lightline vim plugin.        |
| lightline-ale        | ALE indicator for the lightline vim plugin                    |
| vimwiki              | Personal Wiki for Vim                                         |
| calendar-vim         | Creates a calendar you can use within vim                     |
| pomodoro.vim         | Bring the beauty of the Pomodoro technique to Vim             |
| Colorizer            | Color hex codes and color names                               |
| indentLine           | display the indention levels with thin vertical lines         |
| vim-test             | Run your tests at the speed of thought                        |
| vim-isort            | sort python imports using isort                               |
| vim-minimap          | A minimap for vim                                             |
| vim-lsp-settings     | Auto configurations for Language Server for vim-lsp           |

### custom preferences

| plugin         | description |
| -              | -           |
| ale.vim        | bla         |
| calendar.vim   | bla         |
| denite.vim     | bla         |
| deoplete.vim   | bla         |
| dirvish.vim    | bla         |
| goyo.vim       | bla         |
| gutentags.vim  | bla         |
| hotkets.vim    | bla         |
| indentLine.vim | bla         |
| jupytext.vim   | bla         |
| ligthline.vim  | bla         |
| lsp.vim        | bla         |
| neoformat.vim  | bla         |
| pandoc.vim     | bla         |
| startify.vim   | bla         |
| test.vim       | bla         |
| tmux.vim       | bla         |
| vimwiki.vim    | bla         |

### autocompletion

blabla bla

### linting

ale.vim

- python support flake8 and pylint
- lua support luacheck
- c support by clang
- erlang support with syntaxerl


### hotkeys

hotkeys.vim

| hotkey | description | 
| - | - |
| leader n | ale next wrap |
| leader p | ale previous wrap |
|leader -| bla|
|leader \ | bla|
|leader t| bla|
|leader gj| bla|
|leader jq| bla|
|leader tc| color|
|leader s| update|
|leader S| spelling|
|leader e| exit qa!|
|leader f| Denite buffer|
|leader w| DeniteCursorWord grep:.|
|leader x| DeniteProjectDir -start-filter grep:::!|
|leader r| Denite -resume -cursor-pos=+1|
| gy | Goyo |

leader R, replace

leader gg, bla
leader gj, bla
leader gf, bla
leader ga, git fetch
leader gl, git pull
leader gc, git commit
leader gp, git push


leader cg, CMakeGenerate
leader cb, CMakeBuild


leader ct, CMakeBuild test

leader tn, TestNearest

leader tf, TestFile

leader ts, TestSuite -strategy=vimterminal

leader tl, TestLast

I'm also have qe, j, k, qw, qq maped for quickfix stuff (?)

leader qe,

leader j,

leader k,

leader qw,

leader qq


now the F keys

f1, help
f2, maximizer
f3, dirvish
f4, denite
f5, undotree
f5, date on insert mode
f7, calendar.vim
f8, pomodoro.vim
