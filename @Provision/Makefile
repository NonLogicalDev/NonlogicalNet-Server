HOST_FILE = ../@Infrastructure/build/hosts

include ../.Makefile.utils

#######################################################################
#                           Main Interface                            #
#######################################################################
.PHONY: clean wipe

default:
	@echo "Sup! There is no default task. DEAL WITH IT!"
	@echo "============================================"
	@echo "[Top Level Commands:]"
	@echo "- clean -> cleans all the generated files"
	@echo "- wipe  -> deletes everything that was generated"
	@echo "[Prefixes:]"
	@echo "- PROV  -> provisions machines"

clean: 
	$(call mk,"$@")

wipe: clean
	$(call mk,"$@")

#######################################################################
#                            Provisioning                             #
#######################################################################
.PHONY: PROV.dev PROV.prod

PROV.dev: _installSSHConfigDev
	$(call mk,"$@")
	make -C ../@Infrastructure HOST.dev
	ansible-playbook -i $(HOST_FILE) playbook.yml --sudo

PROV.prod: _installSSHConfigProd
	$(call mk,"$@")
	make -C ../@Infrastructure HOST.prod
	ansible-playbook -i $(HOST_FILE) playbook.yml --sudo

# Misc ================================================================

.PHONY: _installSSHConfigDev
_installSSHConfigDev:
	make -C ../@Utils CONF.dev CONF.install

.PHONY: _installSSHConfigProd
_installSSHConfigProd:
	make -C ../@Utils CONF.prod CONF.install
