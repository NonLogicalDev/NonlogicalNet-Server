BUILD_DIR     = build
HOST_PROD     = prodbox
KEY_DIR       = resources/keys

SSH_PEM     = $(KEY_DIR)/ssh/$(SSH_PEM_NAME)
SSH_CONF    = $(BUILD_DIR)/ssh_conf
KEY_LOC_ABS = $(abspath $(SSH_PEM))

include ../.Makefile.utils
include ../.Makefile.vars
#-> imports LOCAL_KEY_DIR variable
#-> imports SSH_PEM_NAME  variable

#######################################################################
#                           Main Interface                            #
#######################################################################
.PHONY: default clean wipe

default:
	@echo "Sup! There is no default task. DEAL WITH IT!"
	@echo "============================================"
	@echo "[Top Level Commands:]"
	@echo "- clean -> cleans all the generated files"
	@echo "- wipe  -> deletes everything that was generated"
	@echo "[Prefixes:]"
	@echo "- LINK  -> Sets up links to files"
	@echo "- CONF  -> manages SSH config files"
	@echo "- SH    -> initiates interactive shell session"

clean: 
	$(call mk,"$@")
	rm -rf $(BUILD_DIR)

wipe: clean LINK.off
	$(call mk,"$@")

#######################################################################
#                        Generating Ssh Keys                          #
#######################################################################
.PHONY: CONF.prod CONF.dev CONF.install

CONF.prod: SSH.conf.prod

CONF.dev: SSH.conf.dev

CONF.install:
	$(call mk,"$@")
	mv $(SSH_CONF) ~/.ssh/config

#######################################################################
#                             Link Things                             #
#######################################################################
.PHONY: LINK.on LINK.off

LINK.on:
	$(call mk,"$@")
ifeq ("$(wildcard $(KEY_DIR)/ssh)","")
	ln -s $(LOCAL_KEY_DIR)/ssh $(KEY_DIR)/ssh
endif
ifeq ("$(wildcard $(KEY_DIR)/ssl)","")
	ln -s $(LOCAL_KEY_DIR)/ssl $(KEY_DIR)/ssl
endif

LINK.off:
	$(call mk,"$@")
	rm -f $(KEY_DIR)/ssh $(KEY_DIR)/ssl

#######################################################################
#                         Shelling into boxes                         #
#######################################################################
.PHONY: SH.dev SH.prod

SH.dev: CONF.dev CONF.install
	$(call mk,"$@")
	@ssh devbox

SH.prod: CONF.prod CONF.install
	$(call mk,"$@")
	@ssh prodbox

# Misc ================================================================

.PHONY: DIR.build
DIR.build:
	@mkdir -p $(BUILD_DIR)

.PHONY: SSH.conf.dev
SSH.conf.dev: DIR.build
	$(call mk,"$@")
	make -C ../@Infrastructure VM.getSsh
	cp ../@Infrastructure/build/ssh_conf $(SSH_CONF)

.PHONY: SSH.conf.prod
SSH.conf.prod: DIR.build
	$(call mk,"$@")
	python scripts/genProdSshConf.py "$(HOST_PROD)" "$(CONFIG_FILE)" "$(KEY_LOC_ABS)" > $(SSH_CONF)
