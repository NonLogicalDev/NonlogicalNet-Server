VM_NAME   = devbox
BUILD_DIR = build

LOCK_FILE = .vagrant_lock
HOST_FILE = $(BUILD_DIR)/hosts
SSH_CONF  = $(BUILD_DIR)/ssh_conf

include ../.Makefile.utils

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
	@echo "- VM    -> manages development Virtual machine"
	@echo "- HOST  -> manages host file for ansible"

clean:
	rm -rf $(BUILD_DIR)

wipe: clean VM.destroy

#######################################################################
#                     Virtual Machine Management                      #
#######################################################################
.PHONY: VM.start VM.stop VM.destroy VM.getSsh VM.shell

VM.start:
ifeq ("$(wildcard $(LOCK_FILE))","")
	$(call mk,"$@")
	vagrant up
	touch $(LOCK_FILE)
endif

VM.stop:
ifneq ("$(wildcard $(LOCK_FILE))","")
	$(call mk,"$@")
	vagrant halt
	@rm -rf $(LOCK_FILE)
endif

VM.destroy: VM.stop
ifneq ("$(wildcard .vagrant)","")
	$(call mk,"$@")
	vagrant destroy -f
	@rm -rf $(LOCK_FILE)
	rm -rf .vagrant
endif

VM.getSsh: $(LOCK_FILE) DIR.build
	$(call mk,"$@")
	vagrant ssh-config --host $(VM_NAME) > $(SSH_CONF)

VM.shell: $(LOCK_FILE)
	$(call mk,"$@")
	vagrant ssh

#######################################################################
#                          Host Management                            #
#######################################################################
.PHONY: HOST.pev HOST.prod

HOST.dev: DIR.build
	$(call mk,"$@")
	cp hosts/hosts_dev $(HOST_FILE)

HOST.prod: DIR.build
	$(call mk,"$@")
	cp hosts/hosts_prod $(HOST_FILE)

# Misc: ===============================================================

.PHONY: DIR.build
DIR.build:
	@mkdir -p build

$(LOCK_FILE): VM.start
