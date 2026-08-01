# Publish-Day Checklist — Cedarwings SAS Operations

Once Google approves your developer identity (email from `googleplay-noreply@google.com`),
work through this list top-to-bottom. Total time: **~2 hours** if all prerequisites are ready.

---

## Phase 1 — Prerequisites (do this NOW, while Google verifies you)

- [ ] Web app deployed at a public HTTPS URL (e.g. `https://cedarwings.com`)
- [ ] `manifest.json`, `sw.js`, `icons/*` all served from the site root
- [ ] `open https://YOUR-DOMAIN/manifest.json` returns valid JSON
- [ ] Privacy policy hosted at `https://YOUR-DOMAIN/privacy` (content from `02_PRIVACY_POLICY.md`)
- [ ] Test manager account created in `employees` table for Google reviewer
- [ ] All 5 screenshots taken and saved in `playstore/screenshots/`
- [ ] Support email account (`support@cedarwings.com`) working and monitored
- [ ] Privacy email account (`privacy@cedarwings.com`) working and monitored

---

## Phase 2 — After Google approves your ID (email received)

### 2.1 Complete phone verification
- [ ] Play Console → **Setup** → **Verify your contact phone number** → enter phone, receive SMS code

### 2.2 Finalise developer profile
- [ ] Play Console → **Setup** → **Developer profile** → confirm displayed name, contact address, website
- [ ] Play Console → **Setup** → **Payments profile** → complete tax info (needed even for free apps)

---

## Phase 3 — Build the .aab file

Choose ONE path from `04_TWA_BUILD.md`:

### If using PWABuilder (browser)
- [ ] Go to <https://www.pwabuilder.com>
- [ ] Paste your URL → package for Android → download ZIP
- [ ] **BACK UP** `signing.keystore` + `signing-key-info.txt` to password manager + cloud drive
- [ ] Copy the SHA-256 fingerprint from `signing-key-info.txt`

### If using Bubblewrap CLI
- [ ] `npm i -g @bubblewrap/cli`
- [ ] Edit `twa-manifest.json` — replace `REPLACE_WITH_YOUR_DOMAIN.com` everywhere
- [ ] `bubblewrap init --manifest=https://YOUR-DOMAIN/manifest.json`
- [ ] `bubblewrap build` → produces `app-release-signed.aab`
- [ ] **BACK UP** `android.keystore` + the passwords printed on init

## Phase 4 — Deploy Digital Asset Links (removes Chrome URL bar)

- [ ] Open `.well-known/assetlinks.json` in this repo
- [ ] Replace `REPLACE:WITH:SHA256:FROM:BUBBLEWRAP:BUILD:OUTPUT` with your actual fingerprint
- [ ] Deploy so `https://YOUR-DOMAIN/.well-known/assetlinks.json` returns 200 with `Content-Type: application/json`
- [ ] Verify: `curl -sI https://YOUR-DOMAIN/.well-known/assetlinks.json`
- [ ] Verify with Google's tool: <https://developers.google.com/digital-asset-links/tools/generator>

---

## Phase 5 — Play Console: create the app

- [ ] Play Console → **Create app**
  - App name: `Cedarwings SAS Operations`
  - Default language: `English (United States)` (add French later)
  - App or game: **App**
  - Free or paid: **Free**
  - Accept declarations → **Create app**

## Phase 6 — Fill in Store listing (~30 min)

- [ ] **Main store listing** → paste values from `01_LISTING.md`
- [ ] Upload **App icon** = `icons/icon-512.png`
- [ ] Upload **Feature graphic** = `icons/feature-graphic-1024x500.png`
- [ ] Upload **Phone screenshots** = all 5 from `playstore/screenshots/`
- [ ] **Add translations** → French → paste the FR strings from `01_LISTING.md`

## Phase 7 — Fill in App content (~20 min)

Use answers from `05_CONTENT_RATING_AND_DATA_SAFETY.md`:

- [ ] **Privacy policy** → paste URL
- [ ] **App access** → provide reviewer test credentials
- [ ] **Ads** → No
- [ ] **Content rating** → complete IARC questionnaire (all "No")
- [ ] **Target audience** → 18+
- [ ] **News app** → No
- [ ] **Data safety** → fill in per pre-filled answers
- [ ] **Government app** → No
- [ ] **Financial features** → No
- [ ] **Health features** → No

## Phase 8 — Choose release track

**Personal accounts (like yours) are REQUIRED to run closed testing first.**

- [ ] **Testing → Closed testing → Create new track** (name it "Alpha")
- [ ] Upload `app-release-signed.aab`
- [ ] Add release notes (see below)
- [ ] Create a **tester list** with at least **12 tester email addresses**
- [ ] Send them the opt-in link, ask each to install from Play Store
- [ ] **Wait 14 continuous days** with 12+ testers active
- [ ] After 14 days → Play Console will unlock **Production** track for you

### Sample release notes
```
Version 1.0.0 — Initial release
• Employee clocking with role-based routing
• Production, quality, inventory, and traceability dashboards
• Bilingual French/English interface
• ISO 13485 compliant workflows
```

## Phase 9 — Submit for review

- [ ] All left-hand sections in Play Console show a **green checkmark**
- [ ] **Send for review** button becomes active → click it
- [ ] Google review typically takes **1–7 days** for a new developer's first app

---

## Post-launch

- [ ] Confirm your app is live: <https://play.google.com/store/apps/details?id=com.cedarwings.ops>
- [ ] Share the Play Store link with employees
- [ ] Set up Play Console → **Statistics** → alerts for crashes and 1-star reviews
- [ ] Every time you change the site: nothing to do — TWA fetches the latest automatically
- [ ] Every time you change `twa-manifest.json` (icon, name, permissions):
  - Bump `appVersionCode` (+1) and `appVersionName`
  - Re-run `bubblewrap build`
  - Play Console → Production → **Create new release** → upload new `.aab`

---

## If something goes wrong

| Symptom | Fix |
|---|---|
| Chrome URL bar visible in the installed app | `assetlinks.json` not reachable, wrong SHA-256, or wrong package_name — re-check |
| Play Console rejects the .aab | Read the rejection email — usually about metadata, not the file itself |
| Reviewer says "can't log in" | Reviewer credentials in `employees` table are wrong or blocked |
| Privacy policy URL fails validation | Must be HTTPS, must return 200, must be publicly reachable (no login wall) |
| "Target API level" error | Bump `targetSdkVersion` in Bubblewrap (`bubblewrap update` handles this automatically) |
