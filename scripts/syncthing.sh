DEVICE_ID="$(syncthing serve --device-id)"
DEVICE_NAME="ThinkPad L380"

# If you configure the syncthing GUI with username and password, be sure to run
# this script after you have entered username and password in the GUI.

# systemctl --user restart syncthing.service
# syncthing serve --reset-database
# syncthing cli operations shutdown

echo "Adding remote devices that can connect to device ID $DEVICE_ID ($DEVICE_NAME)"

# Override any devices added or deleted through the WebUI
syncthing cli config options overwrite-remote-dev-names set true
# TODO: how to override any folders added or deleted through the Web UI?

syncthing cli config devices add --name "Redmi Note 9S" \
  --device-id "7WJ47ZP-O776CHO-OELIPNH-GUOZHA4-UYYZ3WS-PL5BE6L-INDDN3D-FHKDDQQ"

syncthing cli config devices add --name "ThinkPad L390" \
  --device-id "ZUVYNEP-4CMUUH5-6P75652-VYIEQLU-COK4UYC-4RUIO4F-7GAOYDE-BVDP7AM"

syncthing cli config devices add --name "ThinkPad X220" \
  --device-id "WQ2BV2F-VOYX4RT-WBBI26I-U3KCTCV-JRGRQUZ-MNT44DV-COAMMYQ-JPF5EAN"

printf "\nDevices:\n"
syncthing cli config devices list

syncthing cli config folders add --label "Calibre Library" \
  --id "ipxyn-ow6d6" \
  --path "$HOME/Documents/calibre-library"

syncthing cli config folders add --label "Shared Docs" \
  --id "mihyn-ggmuw" \
  --path "$HOME/Documents/shared-docs"

syncthing cli config folders add --label "Shared Music" \
  --id "prz5n-egjgc" \
  --path "$HOME/Music/shared-music"

syncthing cli config folders add --label "Shared Pics" \
  --id "ewwca-actnr" \
  --path "$HOME/Pictures/shared-pictures"

syncthing cli config folders add --label "Shared Videos" \
  --id "bjahe-fyok2" \
  --path "$HOME/Videos/shared-videos"

syncthing cli config folders add --label "Redmi Note 9S Camera" \
  --id "uusn3-urfng" \
  --path "$HOME/Pictures/redmi-note-9s-camera"

syncthing cli config folders add --label "Redmi Note 9S Screenshots" \
  --id "mid9i-b3h7v" \
  --path "$HOME/Pictures/redmi-note-9s-screenshots"

syncthing cli config folders add --label "Redmi Note 9S Movies" \
  --id "hjshj-uh7fa" \
  --path "$HOME/Videos/redmi-note-9s-movies"

printf "\nFolders:\n"
syncthing cli config folders list
