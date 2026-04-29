# GitHub Push Commands

Use these commands from Terminal on your Mac.

```bash
git clone https://github.com/NickFranza/OSX-26.x-Application-Icon-Fix.git
cd OSX-26.x-Application-Icon-Fix

# Copy the contents of this package into the cloned repo folder, then run:
git add .
git commit -m "Initial release: source and macOS app package"
git push origin main
```

## Optional: create a release tag

```bash
git tag -a v1.0.0 -m "IconFix v1.0.0"
git push origin v1.0.0
```

Then create a GitHub Release from tag `v1.0.0` and attach:

```text
releases/IconFix-macOS-App-v1.0.0.zip
```
