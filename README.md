# Wrapper buildout to use coredev

This buildout wraps the coredev buildout.

To use it, provide a `custom.cfg` with something like:

```ini
[buildout]
extends +=
    etc/buildout.coredev/buildout.cfg
```
and run `make`.

If you want to use a PLIP branch use:

```ini
[buildout]
extends +=
    etc/buildout.coredev/plips/plip-filename.cfg
```

If you want to install the robot server be sure that your `custom.cfg` has something like:

```ini
[buildout]
parts +=
    robot
```

If you want to change the port be sure that your `custom.cfg` has something like:

```ini
[instance]
http-address = 8081
```
