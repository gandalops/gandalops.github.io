# GitHub Pages – Errors & Fixes

This log tracks issues I encountered while setting up and deploying my DevSecOps portfolio using GitHub Pages and Jekyll.

---

## ❌ Error 1: 404 – File Not Found After Setting Up Homepage

**Context:**  
After creating and pushing `index.md`, GitHub Pages showed a `404 File Not Found` page.

**Root Cause:**  
GitHub Pages was still trying to load the old `index.html` file, which conflicted with the new Jekyll structure.

**Fix Applied:**
1. Deleted the old `index.html` from the repo
2. Added `_config.yml` to enable Jekyll with Minima theme
3. Committed and pushed both files
4. Enabled GitHub Pages:  
   → `Settings → Pages → Source → main → / (root)`

**Status:** ✅ Resolved  
**Date:** 08 April 2025  
**Tags:** `github-pages`, `jekyll`, `index.md`, `404 error`

---

> I’ll continue to log GitHub Pages–related errors here as I build and publish more blogs, pages, and components.
