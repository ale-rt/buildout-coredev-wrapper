# Wrapper buildout to use coredev

This buildout wraps the coredev buildout.

To use it, provide a `custom.cfg` with something like:

```ini
[buildout]
extends =
    etc/buildout.coredev/buildout.cfg
```
and run `make`.

The file `custom.cfg` **must** provide the `extends` option.

If you want to use a PLIP branch use:

```ini
[buildout]
extends =
    etc/buildout.coredev/plips/plip-filename.cfg
```

If you want to install the robot server be sure that your `custom.cfg` has something like:

```ini
[buildout]
...
parts +=
    robot
```

If you want to change the port be sure that your `custom.cfg` has something like:

```ini
...
[instance]
http-address = 8081
```


## How to specify the Python version to use

By default the `Makefile` will try to use the `python3` executable found in the path.
If you want to use a different version do something like:

```
python3.N -m venv py3
```

before running `make`.
