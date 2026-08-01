# Building the Android App (.aab) with Bubblewrap / PWABuilder

This turns the Cedarwings web app into a signed `.aab` file you upload to Play Console.
Two paths — pick one:

- **Path A — PWABuilder (easiest, no CLI):** works entirely in a browser.
- **Path B — Bubblewrap CLI (more control, better for updates):** requires Node.js + JDK.

Both produce a **Trusted Web Activity (TWA)**: your existing HTTPS site running inside a
Chrome-backed Android shell, no address bar. All updates you push to the site appear
automatically — you only re-upload the `.aab` when you change something Android-side
(icon, name, permissions).

---

## Prerequisites (both paths)

1. Your web app is deployed at a **public HTTPS URL** — e.g. `https://cedarwings.com` or a Vercel URL.
2. The following files (already added to this repo) are served from the root of that domain:
   - `/manifest.json`
   - `/sw.js`
   - `/icons/*`
3. You have chosen a **package name**. Recommended: `com.cedarwings.ops`. This CANNOT be changed after the first upload.

---

## Path A — PWABuilder (browser only, ~10 min)

1. Go to <https://www.pwabuilder.com>.
2. Paste your app URL → **Start**.
3. PWABuilder scores your PWA. Fix any red items (should be none — we already added the manifest, SW, and icons).
4. Click **Package for Stores** → **Android**.
5. Fill in:
   - **Package ID:** `com.cedarwings.ops`
   - **App name:** `Cedarwings SAS Operations`
   - **Launcher name:** `Cedarwings`
   - **Signing key:** *"Create new"* — **DOWNLOAD AND KEEP the `.keystore` file forever.** Losing it means you can never update the app.
   - **Host:** your domain (e.g. `cedarwings.com`)
6. Download the ZIP. It contains:
   - `app-release-signed.aab` ← upload this to Play Console
   - `assetlinks.json` ← host at `https://cedarwings.com/.well-known/assetlinks.json`
   - `signing.keystore` ← **BACK THIS UP TO A PASSWORD MANAGER + SECONDARY LOCATION**
   - `signing-key-info.txt` ← keystore password, alias, key password

---

## Path B — Bubblewrap CLI (repeatable, scriptable)

### Install once
```bash
npm i -g @bubblewrap/cli
# Requires Java 17+. On macOS: brew install openjdk@17
# On Ubuntu: sudo apt install openjdk-17-jdk
```

### Initialize (from repo root, edit twa-manifest.json first — see `/twa-manifest.json`)
```bash
bubblewrap init --manifest=https://cedarwings.com/manifest.json
# Answer prompts, matching the values in twa-manifest.json
```

### Build
```bash
bubblewrap build
```
Produces `app-release-signed.aab` in the working directory.

### Update later (when you bump versionCode)
```bash
bubblewrap update
bubblewrap build
```

---

## Digital Asset Links (required — links the .aab to your website)

Bubblewrap/PWABuilder generates a `assetlinks.json` file that looks like:

```json
[{
  "relation": ["delegate_permission/common.handle_all_urls"],
  "target": {
    "namespace": "android_app",
    "package_name": "com.cedarwings.ops",
    "sha256_cert_fingerprints": ["XX:XX:XX:..."]
  }
}]
```

**Host this file at:**
```
https://cedarwings.com/.well-known/assetlinks.json
```
(exact path, case-sensitive, no redirects, Content-Type `application/json`)

Without this, the app opens with a Chrome address bar visible on top — Google won't reject
the build, but users will hate it.

**Verify** after deploy: `curl -s https://cedarwings.com/.well-known/assetlinks.json | head`

---

## Version numbers

| Field | Value | Notes |
|---|---|---|
| `versionCode` | integer starting at 1, +1 each upload | Play Console REJECTS duplicates |
| `versionName` | display string, e.g. `1.0.0` | Users see this |

Set both in `twa-manifest.json` before every `bubblewrap build`.

---

## Keystore backup — READ THIS

If you lose the `.keystore` file OR its passwords, **you can never update this app again**.
You would have to publish a brand-new app under a new package name and ask every user to reinstall.

Right now, save the keystore to:
1. A password manager (1Password / Bitwarden — attach the file).
2. An encrypted cloud drive folder.
3. Optionally, print the passwords on paper and store in a safe.

Google also offers **Play App Signing** (recommended): during upload, opt in and Google holds the
signing key. You keep an "upload key" locally — if you lose it, Google resets it for you.
Enable this on the FIRST upload — you cannot enable it later without reset friction.
