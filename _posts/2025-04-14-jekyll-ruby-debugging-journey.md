---
layout: single
title: "How I Brought My Broken DevSecOps Blog Back to Life – A Jekyll, Ruby & GitHub Pages Debugging Journey"
date: 2025-04-14
last_modified_at: 2025-04-15
categories: [Jekyll, GitHub Pages, Ruby, Debugging]
tags: [jekyll, ruby, github-pages, minimal-mistakes, blog, errors]
author_profile: true
toc: true
toc_sticky: true
toc_label: "Article Contents"
featured: true
---

Building my DevSecOps portfolio site was a moment of excitement — until it broke. 😅 What started as a clean Jekyll + GitHub Pages setup turned into a deep dive into Ruby versions, unsupported plugins, CI/CD failures, and more. Here’s how I fixed it all, and what I learned in the process.

---

## 🧠 What This Blog Covers
- Ruby version mismatches and GitHub Actions errors
- Plugin compatibility with GitHub Pages
- Liquid template errors (`include_cached`)
- Cleanup strategies to get a clean build
- Importance of building locally before pushing to remote
- How I learned to stay calm and debug methodically
- Reading CI/CD logs carefully and spotting simple config fixes

---

## 🔥 1. Error: `Unknown tag 'include_cached'`

### What Happened:
Jekyll build failed with a Liquid syntax error because the theme was using the {% raw %}{% include_cached %}{% endraw %} tag.

### Root Cause:
`jekyll-include-cache` is **not supported** by GitHub Pages. The newer Minimal Mistakes versions depend on it.

### Fix:
- Downgraded `minimal-mistakes-jekyll` to version `4.22.0`
- Removed `jekyll-include-cache` from `Gemfile` and `_config.yml`

### Preserving the Example:
To keep a reference to the original tag without breaking the build again, I used a raw code block:

````liquid
{% raw %}
{% include_cached somefile.html %}
{% endraw %}
````

This allows me to document the issue without letting Jekyll try to execute the unsupported tag.

---

## 🧱 2. Error: Ruby Version Mismatch (3.1.7 vs 3.2.3)

### What Happened:
GitHub Actions failed with:
> Your Ruby version is 3.1.7, but your Gemfile specified ~> 3.2.3

### Root Cause:
- Local machine was using Ruby 3.2.3 via rbenv
- GitHub Pages expected 3.1.x (based on supported versions)

### Fix:
- Updated `.ruby-version` to `3.1.4`
- Regenerated `Gemfile.lock`
- Ensured GitHub Actions workflow installs the same Ruby version

---

## 🧼 3. Error: Bundle Platform Error

### What Happened:
Bundler threw:
> Your bundle only supports platforms [...] but your local platform is ruby

### Fix:
- Ran `bundle lock --add-platform ruby`
- Committed the updated lockfile

---

## 💣 4. Cache Conflicts and Native Extension Errors

### What Happened:
After switching Ruby versions, native extensions (*.so) were invalid, causing gem installation issues.

### Fix:
Created a `cleanup.sh`:
```bash
#!/bin/bash
rm -rf _site/ .jekyll-cache/ .jekyll-metadata .bundle/ vendor/ Gemfile.lock
bundle clean --force
echo "✅ Clean slate!"
```

---

## 🚧 5. Git Push Syntax Error

### What Happened:
Accidentally used:
```bash
git push add origin
```
Which failed with:
> fatal: 'add' does not appear to be a git repository

### Fix:
Used correct command:
```bash
git push origin main
```

---

## 🔧 6. Actions Version Mismatch in Workflow Config

### What Happened:
The GitHub Pages deploy workflow failed silently without obvious errors.

### Root Cause:
The config was using outdated action versions:
```yaml
- uses: actions/upload-pages-artifact@v2
- uses: actions/deploy-pages@v2
```

### Fix:
Updated the GitHub Actions config to:
```yaml
- uses: actions/upload-pages-artifact@v3
- uses: actions/deploy-pages@v4
```

### Learning:
A simple version update fixed the issue. This taught me to **read build logs carefully**—often, the solution is a one-line fix hiding in plain sight.

---

## 🧠 Lessons I Learned

- 🔍 **Slow down** — most bugs were environment/config errors
- 🧱 **Match Ruby + Gemfile + GitHub Pages versions** using their [official versions page](https://pages.github.com/versions/)
- 🔃 **`bundle lock` is your friend** — pin platforms and versions explicitly
- 🧪 **Test locally** before pushing to GitHub
- 🧘‍♂️ **Patience pays off** — take a break, read the logs, and think
- 💡 **Build locally first to keep your remote clean**

  Run this before pushing:
  ```bash
  bundle exec jekyll build
  ```
  Then verify everything looks good in `_site/` and finally push:
  ```bash
  git push origin main
  ```

---

## 🛠️ Bonus: My Maintenance Script
```bash
#!/bin/bash
# Safe cleaner
rm -rf _site/ .jekyll-cache/ .jekyll-metadata .bundle/ vendor/ Gemfile.lock
bundle clean --force
echo "Ready to rebuild: bundle install && bundle exec jekyll serve"
```

---

If you're debugging your Jekyll site today — trust me, you're not alone. The key is to read the logs, understand your environment, and align everything from Ruby to themes. And yes, don’t forget to commit `Gemfile.lock` 😉

---

💬 **Let's Connect**  
If you have also solved similar issue, I am happy to listen your story or if you have some feedback for me then let’s connect.  
[Open an issue](https://github.com/gandalops/gandalops.github.io/issues) on this blog's repo or  
[Connect on LinkedIn](https://linkedin.com/in/yourprofile)

---
