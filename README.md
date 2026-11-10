# linter-site

Landing page for [Linter](https://github.com/Shimodos/Linter), a tray utility
for Windows that fixes text typed in the wrong keyboard layout and signals
misspelled words.

Astro + Tailwind CSS, one static page, deployed to GitHub Pages by
`.github/workflows/deploy.yml` on every push to `main`.

```powershell
npm install
npm run dev      # http://localhost:4321/linter-site
npm run build    # static site in dist/
```

## What is where

- `src/components/Demo.astro` — the animated demos. Each one is a short script
  of steps (`type`, `key`, `flag`, `beep`, `select`, `replace`...) played inside
  a mock text window. They loop while on screen. Visitors who asked their
  system for reduced motion see the final text and a Play button instead;
  add `?animate` to the URL to force autoplay when checking the animations.
- `src/components/HowItWorks.astro` — the three demo scenes and their text.
- `src/assets/shots/` — screenshots of the settings window. Regenerate them
  from the Linter repository with `dotnet run --project tools/snapshot -- <folder>`
  and copy the `*-en.png` files here.
- `public/favicon.ico`, `public/icon-256.png` — copies of the app icon
  (`src/Linter/Assets` in the Linter repository).
- `public/og.png` — the sharing image, drawn by `pwsh tools/make-og.ps1`.

The download buttons read the latest release from the GitHub API and fall
back to the releases page when there is none or the request fails.
