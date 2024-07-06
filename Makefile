all: install

install:
	stow -v --dotfiles --target=$(HOME) --dir=src .

uninstall:
	stow -v -D --dotfiles --target=$(HOME) --dir=src .
