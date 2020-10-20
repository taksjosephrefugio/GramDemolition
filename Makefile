.DEFAULT_GOAL:= help
.PHONY: help all bash git vimrc

help:
	@echo 'Usage: make [target] '
	@echo
	@echo 'Targets: '
	@echo '    all      - update everything '
	@echo '    bash     - modifies your bash layout, colors, and sets bash aliases '
	@echo '    git      - adds git aliases to your global git config file '
	@echo '    vim      - adds vimrc settings to your local .vimrc file '
	@echo '    help     - print the help information'
	@echo
	@echo 'the word "everything" in the above refers to: '
	@echo '   bash, git, vim '

all:
	$(MAKE) bash
	$(MAKE) git
	$(MAKE) vim

bash:
	@cd scripts; \
		./add_bash_layout.sh
		./add_bash_aliases.sh; \

git:
	@cd scripts; \
		./add_git_aliases.sh

vim:
	@cd scripts; \
		./add_vimrc.sh
