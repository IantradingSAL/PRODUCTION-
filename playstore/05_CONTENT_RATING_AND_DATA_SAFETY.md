# Pre-filled Answers — Content Rating & Data Safety

Google Play requires two mandatory questionnaires before you can publish. Below are the
recommended answers for **Cedarwings SAS Operations** — a private, employee-only
business app. Verify each answer matches your final build before submitting.

---

## A. Content rating questionnaire (IARC)

**Category to select:** *Utility, Productivity, Communication, or Other*

Answer **No** to all of the following:

| Question | Answer |
|---|---|
| Does your app contain any violence? | **No** |
| Does your app contain sexual content or nudity? | **No** |
| Does your app contain profanity or crude humor? | **No** |
| Does your app contain references to controlled substances? | **No** |
| Does your app simulate gambling? | **No** |
| Does your app include user-generated content that could be shared publicly? | **No** *(all content is internal, role-restricted)* |
| Does your app share the user's precise location with other users? | **No** |
| Does your app allow users to interact or exchange content with strangers? | **No** |
| Does your app collect, use, or transmit any personal information? | **Yes** *(name, username, work activity — see Data Safety below)* |
| Is your app intended for or targeted at children? | **No** |

**Expected rating:** Everyone / PEGI 3.

---

## B. Data Safety form

### Data collection & sharing summary
- **Does your app collect or share any of the required user data types?** → **Yes**
- **Is all of the user data collected by your app encrypted in transit?** → **Yes** (HTTPS/TLS everywhere via Supabase)
- **Do you provide a way for users to request that their data is deleted?** → **Yes** (via privacy@cedarwings.com — documented in privacy policy)

### Data types — answer per type

| Data type | Collected? | Shared? | Purpose | Optional? |
|---|---|---|---|---|
| **Name** | Yes | No | Account management, App functionality | Required |
| **User IDs** (username) | Yes | No | Account management, App functionality | Required |
| **Other actions** (clock-in/out, page views, form submissions) | Yes | No | App functionality, Analytics *(internal audit)* | Required |
| **App activity — In-app actions** | Yes | No | App functionality | Required |
| **App info & performance — Diagnostics / Crash logs** | No | No | — | — |
| **Device or other IDs** | No | No | — | — |
| **Location** | No | No | — | — |
| **Photos / videos / files / audio** | No | No | — | — |
| **Contacts / calendar / SMS / call logs** | No | No | — | — |
| **Health & fitness** | No | No | — | — |
| **Financial info** | No | No | — | — |
| **Web browsing history** | No | No | — | — |
| **Messages** | No | No | — | — |
| **Personal info (email address)** | No *(employees log in with username, not email)* | — | — | — |

### Security practices
- ✅ Data encrypted in transit
- ✅ Users can request data deletion
- ✅ Follows Play Families policy: **N/A** (not for children)
- ✅ Independent security review: **No** *(optional — check if you have one)*

---

## C. App content declarations

| Question | Answer |
|---|---|
| **Privacy policy URL** | https://cedarwings.com/privacy *(must be live)* |
| **App access** — is any functionality behind a login? | **Yes** — provide a test account: username + password for a demo employee, so Google reviewers can sign in. Create one before submission. |
| **Ads** | **No, my app does not contain ads** |
| **Content rating** | Complete the questionnaire above |
| **Target audience and content** | Age group: **18+** (workplace app); not primarily for children: **Yes** |
| **News app** | **No** |
| **COVID-19 contact tracing** | **No** |
| **Data safety** | Complete section B above |
| **Government app** | **No** |
| **Financial features** | **No** |
| **Health features** | **No** *(operational tool, not a medical device itself)* |

---

## D. Test account for Google reviewers

Create a dedicated reviewer account in your `employees` table before submission:

```
Username: google-reviewer
Password: (strong, only shared with Google)
Role:     manager
Name:     Google Play Reviewer
```

Provide these credentials in Play Console → App content → **App access** → "All or some functionality in my app is restricted".

Without this, Google's manual review will fail and your submission will be rejected within 1-3 days.
