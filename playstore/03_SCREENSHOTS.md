# Screenshots Guide

Google Play requires **2–8 phone screenshots** (min side 320px, max 3840px, JPEG or 24-bit PNG, 16:9 or 9:16 aspect).
**Recommended: 1080×1920 (portrait 9:16).**

## Take these 5 shots

Capture from a real Android device or Chrome DevTools mobile emulator (Pixel 6 / Pixel 7 profile works well).

| # | Page | What to show | Filename |
|---|------|--------------|----------|
| 1 | `index.html` (Login) | Clean login screen with the Cedarwings logo | `01-login.png` |
| 2 | `manager.html` | Manager dashboard — role-based overview | `02-manager.png` |
| 3 | `production.html` | Production board with live orders | `03-production.png` |
| 4 | `inventory.html` | Inventory with stock levels | `04-inventory.png` |
| 5 | `tracabilite.html` | Traceability screen (highlights ISO compliance) | `05-traceability.png` |

Save all 5 into `/playstore/screenshots/` (folder is created for you but empty until you take them).

## How to capture from Chrome DevTools (fastest, no phone needed)

1. Open your hosted app URL in Chrome.
2. Press `F12` → click the phone icon (top-left of DevTools) → device toolbar opens.
3. Choose **"Pixel 7"** (1080×2400) or set custom **1080 × 1920**.
4. Sign in with a test manager account so the dashboards show real data.
5. Navigate to each page, press `⌘/Ctrl + Shift + P` → type "Capture full size screenshot" → Enter.
6. Save each PNG into `playstore/screenshots/` with the filename above.

## Framing tips

- Show real (or realistic-looking) data — Google rejects screenshots that look like empty templates.
- Avoid personally identifiable info (real employee names, real emails, real phone numbers).
- Use the same test dataset in every screenshot for consistency.
- Do **NOT** overlay marketing text or fake device frames — Google's automated review sometimes flags these.

## Optional: tablet screenshots

Play Console has separate slots for 7" and 10" tablets. They are OPTIONAL but boost visibility for tablet users. If you want them:
- **7" tablet:** 1200×1920 portrait
- **10" tablet:** 1920×1200 landscape

Skip these on day 1 — you can add them post-launch without a new release.
