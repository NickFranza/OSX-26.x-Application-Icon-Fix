# Push to a Clean GitHub Repository

From inside this folder:

```bash
git init
git branch -M main
git add .
git commit -m "Initial release: IconFix macOS app"
git remote add origin https://github.com/NickFranza/OSX-26.x-Application-Icon-Fix.git
git push -u origin main
```

If the remote already exists:

```bash
git remote set-url origin https://github.com/NickFranza/OSX-26.x-Application-Icon-Fix.git
git push -u origin main
```
