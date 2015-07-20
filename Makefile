VAR_FILE = .Makefile.vars

include .Makefile.utils
#-> imports CONFIG_FILE   variable
#-> imports CONFIG_SCRIPT variable

#######################################################################
#                           Main Insterface                           #
#######################################################################
.PHONY: default help neat clean wipe

default: 
	@make -C . init > /dev/null
	@echo "Sup! I just initialized stuff for you       "

help:
	@echo "============================================"
	@echo "[Top Level Commands:]"
	@echo "- clean  -> cleans all the generated files"
	@echo "- wipe   -> deletes everything that was generated"
	@echo "[Prefixes:]"
	@echo "- VM     -> manages development Virtual machine"
	@echo "- SH     -> initiates interactive shell session"
	@echo "- LINK   -> Sets up links to secret files"
	@echo "- DEPLOY -> Deploys your current project"

neat:
	find . -iname .DS_Store | xargs rm

clean: neat
	@touch $(VAR_FILE) # Hack to avoid load errors
	make -C @Infrastructure clean
	make -C @Provision clean
	make -C @Utils clean
	rm -rf $(VAR_FILE)

wipe: clean
	@touch $(VAR_FILE) # Hack to avoid load errors
	make -C @Infrastructure wipe
	make -C @Provision wipe
	make -C @Utils wipe
	rm -rf $(VAR_FILE)

#######################################################################
#                                INIT                                 #
#######################################################################
.PHONY: init

init: $(VAR_FILE)
	@make -C @Utils LINK.off > /dev/null
	make -C @Utils LINK.on

#######################################################################
#                           Virtual Machine                           #
#######################################################################
.PHONY: VM.start VM.stop VM.destroy VM.restart

VM.start: $(VAR_FILE)
	make -C @Infrastructure VM.start

VM.stop: $(VAR_FILE)
	make -C @Infrastructure VM.stop

VM.destroy: $(VAR_FILE)
	make -C @Infrastructure VM.destroy

VM.restart: VM.stop VM.start

#######################################################################
#                            Deploy Stuff                             #
#######################################################################
.PHONY: DEPLOY.dev

DEPLOY.dev: $(VAR_FILE) VM.start
	make -C @Provision PROV.dev

DEPLOY.prod: $(VAR_FILE)
	make -C @Provision PROV.prod

test: $(VAR_FILE)

#######################################################################
#                            Utility Stuff                            #
#######################################################################
.PHONY: SH.dev SH.prod LINK.relink LINK.on LINK.off

SH.dev: $(VAR_FILE)
	make -C @Utils SH.dev

SH.prod: $(VAR_FILE)
	make -C @Utils SH.prod

LINK.relink: LINK.off LINK.on

LINK.on: $(VAR_FILE)
	make -C @Utils LINK.on

LINK.off: $(VAR_FILE)
	make -C @Utils LINK.off

# Misc ================================================================

$(VAR_FILE): $(CONFIG_SCRIPT) $(CONFIG_FILE)
	python $(CONFIG_SCRIPT) $(CONFIG_FILE) >> .Makefile.vars
