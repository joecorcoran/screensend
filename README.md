# screensend

A bash script to upload the most recent screenshot I've taken to a remote
location for public viewing.

## Setup

On OS X, change the default location of screenshots from the desktop to somewhere
more sensible.

```
$ defaults write com.apple.screencapture location ~/Screenshots/
$ killall SystemUIServer
```

Add a `~/.screensend` config file like so:

```
# Mandatory settings
SS_REMOTE_HOST="me@someplace"
SS_REMOTE_DIR="/some/remote/place"
SS_REMOTE_URL="http://my.domain.me/pics/:file"  # :file is replaced with the image filename

# Optional settings
SS_LOCAL_DIR="${HOME}/screens"                  # Default: ${HOME}/Screenshots
```

The remote user needs sudo privileges and a ~/tmp directory. I could probably
make this nicer/do more bootstrapping work, but it's fine.

Finally, make sure `screensend.sh` is executable and in your path.