.PHONY: all
all: .installed.cfg

etc/buildout.coredev:
	mkdir -p etc && cd etc && git clone git@github.com:plone/buildout.coredev.git

py3/bin/buildout: py3/bin/pip3 etc/buildout.coredev etc/buildout.coredev/requirements.txt
	./py3/bin/pip3 install -IUr requirements.txt

py3/bin/pip3:
	python3 -m venv py3

.installed.cfg: py3/bin/buildout etc/buildout.coredev $(wildcard *.cfg etc/buildout.coredev/*.cfg)
	./py3/bin/buildout
