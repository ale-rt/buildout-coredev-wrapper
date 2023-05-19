# Wrapper buildout to use coredev

This buildout wraps the coredev buildout.

Run it `./configure`, reply some basic questions.

Like:

- Python version to use
- Plone version to use
- HTTP port to use
- If you want to use the default `buildout.cfg` file or a plip branch

Note that the path you provide has to be relative to the `buildout.coredev`
directory, e.g.: `plips/plip-1234-foo-bar`.

The configure script will create a `Makefile.config` file.
You can edit it also manually or you can rerun `./configure` to change it.

Then ran `make`.

It will bootstrap for you:

- a Python virtual environment in the `.venv` directory
- a `buildout.cfg` file
- it will run buildout

You can at this point edit the `buildout.cfg` file to add eggs, zcml, etc.
