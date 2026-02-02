# MiniOS
A mini operating system

## Quick start ✅

Prerequisites:
- nasm
- qemu-system-x86_64

Build:
```
make
```

Run (persistent build artifacts in `build/`):
```
make run
```

Run (ephemeral — build artifacts are created in /tmp and removed when QEMU exits):
```
make ephemeral
```

Clean up build files:
```
make clean      # remove files inside build/
make purge      # remove build/ directory entirely
rm -rf /tmp/minios-*  # remove any leftover ephemeral dirs
```

This setup boots a simple 16-bit boot sector that prints a message in QEMU. Artifacts are kept in `build/` and can be deleted anytime using `make purge`. This keeps your system unchanged and storage efficient.

## Windows & Browser testing 🪟🌐

- Windows: Install `nasm` and `qemu-system-x86` via your package manager (WSL), or install them natively. You can use `make run` or `make ephemeral` from WSL or a Linux-like environment. Alternatively, you can use the web emulator below.

- Web emulator: There's a lightweight web UI in `web/` that uses an in-browser emulator (v86) to load `build/boot.img` and run it in your browser without installing QEMU. Steps:
  1. `make` to create `build/boot.img`
  2. Serve the repo root: `python3 -m http.server 8000`
  3. Open `http://localhost:8000/web/` and click **Start emulator**

If you want a public online demo, I added a GitHub Actions workflow (`.github/workflows/pages.yml`) that builds `boot.img` and publishes `web/` (including `build/boot.img`) to **GitHub Pages** on pushes to `main` or when triggered manually.

Live demo URL (project site):
- After the first successful run, your site will be available at `https://<OWNER>.github.io/<REPO>/` (for example: `https://logangoogledev.github.io/MiniOS/`).

How it works:
1. The workflow installs `nasm`, builds `build/boot.img`, copies `web/` into a `site/` directory and includes `build/boot.img` at `site/build/boot.img`.
2. The `site/` directory is uploaded and deployed to GitHub Pages automatically.

If you'd like, I can also:
- Add a badge to this `README` showing the Pages site URL or deployment status. ✅
- Add a scheduled workflow that rebuilds/deploys automatically on a schedule. 🔁

