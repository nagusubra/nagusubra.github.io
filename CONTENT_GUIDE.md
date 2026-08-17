# Content guide

Working notes on voice and structure for this site. Read this before
drafting a new post -- for you, and for any AI assistant you hand a
draft to.

## Who this is for

Primarily: people who might want to collaborate -- employers, fellow
engineers, startup founders. Secondarily: anyone who stumbles in from a
search or a link and finds something worth their 60 seconds.

The bar for a post: someone should leave thinking either "I learned
something real" or "this person seems worth talking to."

## Voice

**Witty and warm.** Not corporate, not try-hard-funny. Say things
plainly, let the personality come from specificity and honesty rather
than jokes bolted on. If a sentence could appear on any blog, cut it or
sharpen it until it couldn't.

- Short sentences over long ones.
- Concrete details over abstractions ("a rule-based classifier that
  flags flatlines and out-of-range values" beats "a robust data quality
  solution").
- Opinions stated directly, with the reasoning shown -- that's what
  makes a take a *take* and not just an observation.
- First person, present tense where it makes sense. This is a person
  talking, not a press release.

## Post types

Both live in `src/content/blog/` as the same collection, just
different `kind`:

- `kind: "essay"` -- longer-form, a real argument or story. Patterns
  you've noticed, things you've built and what you learned, takes
  you've thought through.
- `kind: "note"` -- short, punchy, closer to a "hot take." A paragraph
  or two is fine. Doesn't need a thesis statement, just a real opinion.

## Frontmatter checklist

Every post needs: `title`, `description` (1-2 sentences -- this shows up
in the writing list, RSS, and social previews, so make it earn its
place), `publishDate`, `tags`, `kind`, `draft`.

Leave `draft: true` while it's in progress. Flip to `false` and set the
real `publishDate` when it's ready to go live -- that's the entire
publish step, no other config needed.

## Start a new post

Copy `templates/new-post-template.md` into `src/content/blog/` with a
descriptive filename (e.g. `sql-vs-pandas-for-scada-cleanup.md`), fill it
in, done.
