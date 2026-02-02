MiniOS — Web Emulator

This simple web UI uses v86 (via the CDN) to load `build/boot.img` from the repo root and run it in the browser.

Local usage:
1. Build the boot image: `make`
2. Serve the repo root so `build/boot.img` is available to the page. Simple options:
   - `python3 -m http.server 8000` (Linux/macOS/Windows with Python installed)
   - `npx serve .` (Node.js)
3. Open `http://localhost:8000/web/` in your browser and click **Start emulator**.

Notes for Windows users:
- You can use PowerShell: `python -m http.server 8000` if Python is installed.
- If you don't want to run anything locally, push the repo to GitHub and enable GitHub Pages on the `gh-pages` branch or use the `deploy` workflow (follow-up task) to publish the `build/` image and `web/` site.

Security:
- The emulator runs entirely in the browser — it does not have direct access to your files beyond what the browser provides.
- The web UI requires the `build/boot.img` to be served from the same origin (no cross-site fetches by default).