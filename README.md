This is stuff I make randomly. There is no real (free) support whatsoever, but if you find a bug, please file an issue.

# Installation

```shell
emerge app-eselect/eselect-repository
eselect repo enable tatsh-overlay
emerge --sync
```

## Only unmask packages you use from this repository

Based on [Masking installed but unsafe ebuild repositories](https://wiki.gentoo.org/wiki/Ebuild_repository#Masking_installed_but_unsafe_ebuild_repositories).

In `/etc/portage/package.mask/tatsh-overlay`:

```
*/*::tatsh-overlay
```

In `/etc/portage/package.unmask/tatsh-overlay` (example):

```
games-arcade/stepmania::tatsh-overlay
```
