install: install-i3 install-tmux install-desktop install-zsh\
 install-ranger install-vim install-xr

install-i3:
		mkdir -p ~/.i3
		rm -f ~/.i3/config
		rm -f ~/.i3/i3status.conf
		ln -s `pwd`/config/i3/config ~/.i3/config
		ln -s `pwd`/config/i3/i3status.conf ~/.i3/i3status.conf
		ln -s `pwd`/config/i3/lock ~/.i3/lock 
		ln -s `pwd`/config/i3/lock.png ~/.i3/lock.png
		ln -s `pwd`/config/i3/text.png ~/.i3/text.png

install-tmux:
		rm -f ~/.tmux.conf
		ln -s `pwd`/config/tmux/tmux.conf ~/.tmux.conf

install-desktop:
		mkdir -p ~/.config/desktop/
		ln -s `pwd`/images/ophelia.jpg ~/.config/desktop/ophelia.jpg

install-zsh:
		rm -f ~/.zshrc
		ln -s `pwd`/config/zsh/zshrc ~/.zshrc

install-ranger:
		ranger --copy-config=scope
		rm -f ~/.config/ranger/rc.conf
		ln -s `pwd`/config/ranger/rc.conf ~/.config/ranger/rc.conf

install-vim:
		mkdir -p ~/.vim/autoload
		mkdir -p ~/.vim/bundle
		rm -f ~/.vimrc
		ln -s `pwd`/config/vim/vimrc ~/.vimrc
		curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
		git clone https://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible
		git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
		git clone https://github.com/w0rp/ale.git ~/.vim/bundle/ale
		git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
		git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git ~/.vim/bundle/nerdtree-git-plugin
		git clone https://github.com/elzr/vim-json.git ~/.vim/bundle/vim-json
		git clone https://github.com/tbastos/vim-lua.git ~/.vim/bundle/vim-lua
		git clone https://github.com/lfe/vim-lfe.git ~/.vim/bundle/vim-lfe

install-xr:
		rm -f ~/.Xresources
		ln -s `pwd`/config/Xresources ~/.Xresources
