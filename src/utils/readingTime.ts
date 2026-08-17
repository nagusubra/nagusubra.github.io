const WORDS_PER_MINUTE = 220;

// Rough reading time from the raw Markdown body of a post. Used on the
// writing list and post pages -- a small SEO/AEO and UX win with zero JS.
export function readingTimeMinutes(body: string, fallback = 1): number {
  const words = body.trim().split(/\s+/).filter(Boolean).length;
  return words === 0 ? fallback : Math.max(1, Math.round(words / WORDS_PER_MINUTE));
}