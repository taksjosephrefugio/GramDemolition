.DEFAULT_GOAL:= help
.PHONY: help all bash git vim permission

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
#	Fix possible file permissions issue
	$(MAKE) permission

	@echo "###############################################"
	@echo "#                    BASH                     #"
	@echo "###############################################"
	@echo

	@cd scripts; \
		./add_bash_layout.sh; \
		./add_bash_aliases.sh;

	@echo

git:
#	Fix possible file permissions issues
	$(MAKE) permission

	@echo "###############################################"
	@echo "#                     GIT                     #"
	@echo "###############################################"
	@echo

	@cd scripts; \
		./add_git_aliases.sh

	@echo

vim:
#	Fix possible file permissions issues
	$(MAKE) permission

	@echo "###############################################"
	@echo "#                     VIM                     #"
	@echo "###############################################"
	@echo

	@cd scripts; \
		./add_vimrc.sh

	@echo

permission:
#	Set all scripts as executable
	@chmod +x scripts/*

#	Set all command aliases as executable
	@chmod +x CommandCenter/*
