# Satisfactory Dedicated Server

This is a container for the official Satisfactory dedicated server. It will auto-update on an interval and on startup.

## Ports

- 15000 - UDP
- 15777 - UDP
- 7777 - UDP

## Volumes

- `/saves` This is your save game data that is typically found in `C:\Users\<user>\AppData\Local\FactoryGame\Saved\SaveGames\`
- `/data/Satisfactory` Game installation data. Bind this in case you don't want the container to redownload the server on every restart.

## Environment Variables

- `AUTO_UPDATE_INTERVAL` amount of time to wait between update checks in seconds, default: `3600`