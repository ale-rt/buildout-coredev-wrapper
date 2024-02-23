include Makefile.config

.PHONY: all
all: .installed.cfg

.PHONY: pull
pull: etc/buildout/buildout.coredev
	cd etc/buildout/buildout.coredev && git pull

etc/buildout/base.cfg:
	@echo "Creating etc/buildout/base.cfg"
	@echo "# Make generated, do not edit, edit custom.cfg instead" > etc/buildout/base.cfg
	@echo "[buildout]" >> etc/buildout/base.cfg
	@echo "extends ="  >> etc/buildout/base.cfg
	@echo "    buildout.coredev/$(BUILDOUT_MAIN_FILE)" >> etc/buildout/base.cfg
	@echo "    overrides.cfg" >> etc/buildout/base.cfg

custom.cfg:
	@echo "Creating custom.cfg"
	@echo "# Put your custom settings here" > custom.cfg
	@echo "[buildout]" >> custom.cfg

buildout.cfg: custom.cfg etc/buildout/base.cfg
	@echo "Creating buildout.cfg"
	@echo "[buildout]" > buildout.cfg
	@echo "extends ="  >> buildout.cfg
	@echo "    etc/buildout/base.cfg" >> buildout.cfg
	@echo "    custom.cfg" >> buildout.cfg
	@echo "" >> buildout.cfg
	@echo "[instance]" >> buildout.cfg
	@echo "http-address = $(HTTP_ADDRESS)" >> buildout.cfg

etc/buildout/buildout.coredev:
	mkdir -p etc/buildout
	cd etc/buildout && git clone --branch $(PLONE_COREDEV_BRANCH) git@github.com:plone/buildout.coredev.git

.venv/bin/pip3:
	@echo "Creating a virtualenv using $$(which python${PYTHON_VERSION})"
	$$(which python${PYTHON_VERSION}) -m venv .venv

.venv/bin/buildout: .venv/bin/pip3 etc/buildout/buildout.coredev etc/buildout/buildout.coredev/requirements.txt etc/buildout/base.cfg buildout.cfg
	./.venv/bin/pip3 uninstall -qy setuptools zc.buildout
	./.venv/bin/pip3 install -IUr requirements.txt

.installed.cfg: .venv/bin/buildout etc/buildout/buildout.coredev $(wildcard *.cfg etc/buildout/*.cfg etc/buildout/buildout.coredev/*.cfg)
	./.venv/bin/buildout
