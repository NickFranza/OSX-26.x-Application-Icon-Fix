# IconFix v2 — Native macOS App

IconFix is a small native macOS Swift app that repairs missing, broken, stale, or generic application icons by clearing the macOS icon services cache and restarting Finder and Dock.

## What changed in v2

- Native SwiftUI macOS app instead of an AppleScript-only app wrapper
- Branded app window with visible confirmation prompt
- Progress state while running
- Completion/error alert
- App icon asset catalog included
- Xcode project included for normal macOS development workflow

## What IconFix does

When approved by the user, IconFix runs:

```bash
rm -rfv /Library/Caches/com.apple.iconservices.store
killall Dock
killall Finder
```

The command is executed through macOS administrator authorization using AppleScript from the native Swift app.

## Install

1. Download the release ZIP from `releases/` or GitHub Releases.
2. Unzip it.
3. Drag `IconFix.app` into `/Applications`.
4. Right-click `IconFix.app` and choose **Open** the first time.
5. Click **Run IconFix**.
6. Approve the administrator prompt.

## Build from source

Open the project in Xcode:

```bash
open IconFix.xcodeproj
```

Then build/run the `IconFix` scheme.

Or build from Terminal:

```bash
chmod +x scripts/build-release.sh
./scripts/build-release.sh
```

The packaged app will be created at:

```text
releases/IconFix-v2.0.0-Native-macOS-App.zip
```

## Repository structure

```text
IconFix-v2-Native-macOS/
├── IconFix.xcodeproj/
├── IconFix/
│   ├── Assets.xcassets/
│   │   └── AppIcon.appiconset/
│   ├── Info.plist
│   └── Sources/
│       ├── ContentView.swift
│       └── IconFixApp.swift
├── assets/
│   ├── IconFix.icns
│   └── IconFix.png
├── scripts/
│   └── build-release.sh
├── releases/
├── .gitignore
├── LICENSE
└── README.md
```

## macOS security note

This app is unsigned by default. macOS Gatekeeper may require **right-click → Open** on first launch. For public distribution, sign and notarize the app with an Apple Developer account.

## Code signing later

After adding your Apple Developer Team ID in Xcode, archive the app using Product → Archive, then distribute as a Developer ID app and notarize it.

## License

MIT License. See `LICENSE`.
