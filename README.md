# macOS 26.x Application Icon Fix

A small macOS utility that repairs missing, broken, or stale application icons by clearing the macOS icon services cache and restarting Finder and Dock.

## Why this exists

After macOS updates, app migrations, beta upgrades, or cache corruption, application icons can appear blank, generic, duplicated, or outdated. **IconFix** gives Mac users and IT support teams a fast one-click repair option.

## What IconFix does

IconFix runs the following maintenance actions:

```bash
sudo rm -rfv /Library/Caches/com.apple.iconservices.store
killall Dock
killall Finder
```

The app version prompts for administrator approval before running the repair.

## Download / Release

The packaged app is available in the `releases/` folder:

```text
releases/IconFix-macOS-App-v1.0.0.zip
```

## Install

1. Download `IconFix-macOS-App-v1.0.0.zip` from the `releases/` folder or GitHub Releases.
2. Unzip the file.
3. Drag `IconFix.app` into `/Applications`.
4. Right-click `IconFix.app` and choose **Open** the first time.
5. Approve the admin prompt.

## Run from Terminal instead

```bash
chmod +x scripts/iconfix.sh
./scripts/iconfix.sh
```

## Build the app from source

On macOS:

```bash
chmod +x scripts/build-app.sh
./scripts/build-app.sh
```

## Repository structure

```text
OSX-26.x-Application-Icon-Fix/
├── IconFix.app
├── LICENSE
├── README.md
├── releases/
│   └── IconFix-macOS-App-v1.0.0.zip
├── scripts/
│   ├── build-app.sh
│   └── iconfix.sh
├── src/
│   └── IconFix.applescript
└── screenshots/
```

## Notes

- Finder and Dock will restart during the process.
- The app is currently unsigned, so macOS Gatekeeper may require **right-click → Open** on first launch.
- This utility is intended for local Mac troubleshooting and endpoint support scenarios.

## License

MIT License. See `LICENSE`.
