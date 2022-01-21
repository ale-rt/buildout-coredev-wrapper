.PHONY: all
all: .installed.cfg

etc/buildout.coredev:
	cd etc && git clone git@github.com:plone/buildout.coredev.git

py39/bin/buildout: py39/bin/pip3.9 etc/buildout.coredev etc/buildout.coredev/requirements.txt
	./py39/bin/pip3.9 install -IUr etc/buildout.coredev/requirements.txt
	./py39/bin/pip3.9 install pdbpp

py39/bin/pip3.9:
	python3.9 -m venv py39

.installed.cfg: py39/bin/buildout etc/buildout.coredev $(wildcard *.cfg etc/buildout.coredev/*.cfg)
	./py39/bin/buildout
