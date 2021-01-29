This is stuff I make randomly. If you find a bug, please [file an issue](https://github.com/Tatsh/tatsh-overlay/issues/new).

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
