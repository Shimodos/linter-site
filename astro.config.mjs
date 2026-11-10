// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

// Project page on GitHub Pages: https://shimodos.github.io/linter-site
// For a custom domain later: set `site` to the domain and remove `base`.
export default defineConfig({
  site: 'https://shimodos.github.io',
  base: '/linter-site',
  compressHTML: true,
  vite: {
    plugins: [tailwindcss()],
  },
});
