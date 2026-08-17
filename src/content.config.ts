import { defineCollection, z } from "astro:content";
import { glob } from "astro/loaders";

// Every post (essay, hot take, TIL, note) lives in src/content/blog/
// as a single Markdown or MDX file. See templates/new-post-template.md
// for a blank starting point, and CONTENT_GUIDE.md at the repo root for
// voice/style notes.
const blog = defineCollection({
  loader: glob({ pattern: "**/*.{md,mdx}", base: "./src/content/blog" }),
  schema: z.object({
    title: z.string(),
    // One or two sentences. Shows in the blog list, RSS, and social
    // previews (og:description) -- this is doing SEO/AEO work, not just decoration.
    description: z.string(),
    publishDate: z.date(),
    updatedDate: z.date().optional(),
    // Loose tagging so "hot takes" and longer essays can live in the same
    // list but still be filtered/labeled differently if you want later.
    tags: z.array(z.string()).default([]),
    // Short, punchy posts (hot takes/notes) vs longer essays -- purely
    // cosmetic (affects the label shown), doesn't change where it lives.
    kind: z.enum(["essay", "note"]).default("essay"),
    draft: z.boolean().default(false),
  }),
});

// The photo dump: one file per "photo" in src/content/photos/. The image
// itself lives in public/photos/ (Add to this repo as-is, no optimization
// pass needed). See templates/new-photo.md for a blank starting point.
const photos = defineCollection({
  loader: glob({ pattern: "**/*.{md,mdx}", base: "./src/content/photos" }),
  schema: z.object({
    // Path inside public/, e.g. "/photos/clouds.jpg".
    image: z.string(),
    alt: z.string(),
    caption: z.string(),
    date: z.date(),
    location: z.string().optional(),
    draft: z.boolean().default(false),
  }),
});

export const collections = { blog, photos };
