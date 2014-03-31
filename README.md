This is stuff I make randomly. There is no real (free) support whatsoever, but if you find a bug, please file an issue.

# To install with layman

```bash
layman -o https://raw.githubusercontent.com/Tatsh/tatsh-overlay/master/layman.xml -fa tatsh-overlay
```

# `media-video/gpac` and `dev-libs/libfreenect`

Currently libfreenect and gpac are not compatible (gpac is to blame). The work-around for this is to install gpac before installing libfreenect. If you need to upgrade gpac, uninstall libfreenect first, then install gpac, then reinstall libfreenect. I have not yet figured out if there is a way to override this behaviour with `/etc/portage/env` (`CFLAGS="$CFLAGS -UFREENECT_MINIMAL"` does not seem to work).
