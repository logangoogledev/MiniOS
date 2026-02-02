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

Troubleshooting & fallbacks:
- If the browser console shows `ReferenceError: V86Starter is not defined`, the v86 script failed to load from the CDN. The page now tries local vendor files first (`/web/vendor/libv86.js`) and then two CDN locations (copy.sh and jsDelivr). If all fail, the UI shows a helpful error message.
- To run fully offline or in locked-down environments, run `./scripts/vendor_v86.sh` to download `libv86.js` and `v86.so` into `web/vendor/`. The Pages workflow is updated to run this script automatically so deployed sites include the runtime.
- If the emulator fails to fetch the WASM (`v86.so`), ensure `web/vendor/v86.so` exists or update `index.html` to point `wasm_path` to a hosted binary you control.

Security:
- The emulator runs entirely in the browser — it does not have direct access to your files beyond what the browser provides.
- The web UI requires the `build/boot.img` to be served from the same origin (no cross-site fetches by default).