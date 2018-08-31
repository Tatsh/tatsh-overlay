This is stuff I make randomly. There is no real (free) support whatsoever, but if you find a bug, please file an issue.

# Installation

## Recommended way

Add a new file to `/etc/portage/repos.conf.d/` with the following contents:

```ini
[tatsh-overlay]
location = /var/lib/tatsh-overlay
sync-type = git
sync-uri = https://github.com/Tatsh/tatsh-overlay.git
sync-git-verify-commit-signature = no
sync-depth = 1
```

## Layman

```bash
layman -o https://raw.githubusercontent.com/Tatsh/tatsh-overlay/master/layman.xml -fa tatsh-overlay
```

Run `layman -S` for updates.
