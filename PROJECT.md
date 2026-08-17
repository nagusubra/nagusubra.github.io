# Project context

This file holds the internal technical documentation for this repo. It's
meant for maintainers/contributors, not site visitors. The public-facing
README deliberately stays short.

## Stack

- **Astro** -- pages render to static HTML at build time.
- **Tailwind CSS v4** -- utility styling, no separate config file needed.
- **Markdown/MDX content collections** -- every blog post is one file in
  `src/content/blog/`.
- **@astrojs/sitemap** + a hand-written RSS route -- both generated at
  build time, no manual upkeep.
- Self-hosted **Geist** variable fonts (SIL OFL licensed) in
  `public/fonts/` -- no external font request, keeps first paint fast.

## Local development

```bash
npm install
npm run dev       # http://localhost:4321
npm run build     # outputs to dist/
npm run preview   # serve the production build locally
```

## Project structure

```
src/
  data/
    site.ts       # name, tagline, bio -- edit this for any copy change
    projects.ts    # the Projects list on the homepage
    socials.ts     # footer social links + their SVG icons
  content/
    writing/       # blog posts (Markdown/MDX), one file per post
    photos/        # photo dump entries, one file per photo
    config.ts       # frontmatter schemas for both collections
  pages/
    index.astro           # homepage
    photos/index.astro    # photo dump
    writing/index.astro    # blog list
    writing/[...slug].astro # individual post
    rss.xml.js              # RSS feed
public/
  photos/          # the actual image files, referenced from content/photos/
  subu-logo.jpg    # master logo (312x312) -- the whole favicon set is generated from this
  favicon.ico      # multi-size (16/32/48) icon for tabs, bookmarks, address bar
  favicon-16x16.png  # PNG fallback for browsers that skip the .ico
  favicon-32x32.png  # high-DPI tab icon + the header logo on the site
  apple-touch-icon.png # 180x180 iOS home-screen icon
  icon-192.png / icon-512.png # PWA app icons, referenced from site.webmanifest
  site.webmanifest # PWA manifest (name, theme color, icons)
  social-card.png  # 1200x630 Open Graph share card (Facebook/WhatsApp/etc)
  twitter-card.png # 1200x675 Twitter/X share card
  google03b204e9872dc50f.html # Google Search Console verification -- keep it
scripts/
  gen-favicon.ps1  # regenerates the whole favicon set from public/subu-logo.jpg
templates/
  new-post-template.md   # copy into src/content/blog/ for a new post
  new-photo.md           # copy into src/content/photos/ for a new photo
CONTENT_GUIDE.md          # voice/style notes -- read before drafting
```

## Favicon / site icon

All icons come from one source file, `public/subu-logo.jpg`. To restyle
the favicon:

1. Replace `public/subu-logo.jpg` with your new logo (square best).
2. Regenerate the set:

   ```powershell
   powershell -File scripts/gen-favicon.ps1 -Source public/subu-logo.jpg -OutDir public
   ```

3. Bump the `?v=` query string on the icon links in
   `src/layouts/Base.astro` (e.g. `href="/favicon-32x32.png?v=3"`) so
   browsers that cache favicons aggressively fetch the new one, then
   commit and push.

Regenerating the PNGs also updates the header/favicon usage anywhere they
are referenced. The favicon set is what actually gets served, so keep the
`?v=` bump in step 3 and hard-refresh the browser tab after deploy.

## Publishing a new post

1. Copy `templates/new-post-template.md` into `src/content/blog/` with
   a descriptive filename.
2. Fill in the frontmatter and write the post. Leave `draft: true` while
   you're working on it -- draft posts never show up on the live site.
3. When ready: set `draft: false`, set `publishDate` to today, commit,
   and push to `main`.
4. GitHub Actions rebuilds and redeploys automatically. The post appears
   on `/writing`, in `rss.xml`, and in the sitemap with no other steps.

## Publishing a photo

1. Drop the image file into `public/photos/`.
2. Copy `templates/new-photo.md` into `src/content/photos/` and set the
   `image` path to match, plus a caption and `alt` text.
3. Set `draft: false`, commit, and push. The photo appears on `/photos`,
   newest first, with no other steps.

## Deployment

The site is deployed to GitHub Pages via GitHub Actions (see
`.github/workflows/deploy.yml`). Pushing to `main` triggers an automatic
build + deploy; the first run takes ~1-2 minutes.

### First-time setup: create the repo and go live

1. **Create a new, empty repo on GitHub** named `nagusubra.github.io`
   (that exact name gives you the cleanest possible Pages URL:
   `https://nagusubra.github.io`, no `/repo-name` in the path). Don't
   initialize it with a README/license -- it needs to be empty.

2. **Push this project to it:**

   ```bash
   git init
   git add .
   git commit -m "Initial site"
   git branch -M main
   git remote add origin https://github.com/nagusubra/nagusubra.github.io.git
   git push -u origin main
   ```

3. **Turn on GitHub Pages with Actions as the source:**
   Repo -> Settings -> Pages -> under "Build and deployment", set
   **Source** to **GitHub Actions**. That's it -- the workflow in
   `.github/workflows/deploy.yml` handles the rest. Push to `main` and
   check the **Actions** tab; the first run takes ~1-2 minutes.

4. Once it's live, visit `https://nagusubra.github.io`.

### Adding a custom domain later

You don't need to touch any code:

1. Buy the domain wherever you like (Namecheap, Porkbun, Cloudflare
   Registrar, etc).
2. At your DNS provider, add either:
   - An `A` record pointing `@` to GitHub's Pages IPs
     (`185.199.108.153`, `.109.153`, `.110.153`, `.111.153`), or
   - A `CNAME` record pointing a subdomain (e.g. `www`) at
     `nagusubra.github.io`.
3. In the repo: Settings -> Pages -> **Custom domain** -> enter your
   domain. GitHub commits a `CNAME` file to the repo automatically and
   provisions HTTPS for you (can take up to 24h).
4. Update `SITE_URL` in `astro.config.mjs` to your new domain, and the
   URL in `public/robots.txt` and `public/llms.txt` to match, so
   canonical links/sitemap/RSS all point at the right place. Commit and
   push.

## SEO / AEO notes

- Every page has a canonical URL, description, and Open Graph/Twitter
  cards (`src/layouts/Base.astro`): `og:image` points at
  `public/social-card.png` (1200x630 -- the universal standard used by
  Facebook, Instagram, LinkedIn, WhatsApp, Slack, Telegram), and
  `twitter:image` at `public/twitter-card.png` (1200x675 -- X/Twitter's
  native ratio), plus `twitter:card=summary_large_image`,
  `twitter:site`, and `article:*` tags on posts. Replace those two PNGs
  any time to restyle every link preview on the site.
- JSON-LD structured data: `Person` schema site-wide (with `sameAs`
  listing every social profile), `WebSite` schema, and `BlogPosting`
  schema on every post -- this is what helps both Google and AI answer
  engines correctly attribute content to you.
- `public/llms.txt` is a plain-text summary for AI crawlers (the
  emerging `llms.txt` convention -- see llmstxt.org). Keep it in sync as
  you add real projects and posts.
- Sitemap (`/sitemap-index.xml`) and RSS (`/rss.xml`) are both generated
  automatically at build time from whatever's in `src/content/blog/`.
