This is stuff I make randomly. There is no real (free) support whatsoever, but if you find a bug, please file an issue.

## To install with layman

Add ```http://tatsh.github.com/tatsh-overlay/layman.xml``` to ```/etc/layman/layman.cfg```

```bash
overlays  : http://www.gentoo.org/proj/en/overlays/repositories.xml
            http://tatsh.github.com/tatsh-overlay/layman.xml
```

```bash
layman -L
layman -a tatsh-overlay
```
