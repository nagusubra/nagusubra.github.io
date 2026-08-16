import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import sitemap from "@astrojs/sitemap";
import tailwindcss from "@tailwindcss/vite";

// EDIT ME: once you have a custom domain, change `site` below.
// Until then this stays as your GitHub Pages URL so sitemap/RSS/canonical
// links are correct. Nothing else needs to change when you switch.
const SITE_URL = "https://nagusubra.github.io";

export default defineConfig({
  site: SITE_URL,
  integrations: [mdx(), sitemap()],
  vite: {
    plugins: [tailwindcss()],
  },
  markdown: {
    shikiConfig: {
      themes: { light: "github-light", dark: "github-dark" },
    },
  },
});
