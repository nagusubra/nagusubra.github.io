import fs from 'fs';
import path from 'path';
const src = path.resolve('src/content/blog');
const outBase = path.resolve('public/writing');
const files = fs.readdirSync(src).filter(f => f.endsWith('.md'));
for (const f of files) {
  const slug = path.basename(f, '.md');
  const dir = path.join(outBase, slug);
  fs.mkdirSync(dir, { recursive: true });
  const html = `<!doctype html>\n<html lang="en">\n<head>\n  <meta charset="utf-8">\n  <meta http-equiv="refresh" content="0; url=/blog/${slug}/">\n  <link rel="canonical" href="https://nagusubra.github.io/blog/${slug}/">\n  <title>Page moved</title>\n</head>\n<body>\n  <p>This page has moved to <a href="/blog/${slug}/">/blog/${slug}/</a>.</p>\n</body>\n</html>`;
  fs.writeFileSync(path.join(dir, 'index.html'), html, 'utf8');
  console.log('WROTE redirect for', slug);
}
