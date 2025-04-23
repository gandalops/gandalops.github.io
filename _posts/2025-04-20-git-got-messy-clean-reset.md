---
layout: single
title: "Git Got Messy: How I Safely Reverted to a Clean Commit Without Losing My Work"
date: 2025-04-20
last_modified_at: 2025-04-20
categories: [DevSecOps, Git]
tags: [git, reset, backup, branching, dev workflow, wip]
excerpt: "My Git working directory got messy after hours of local experimentation. Here's how I backed up my changes, reset cleanly, and what I learned about safe Git workflows."
author_profile: true
read_time: true
toc_sticky: true
toc_label: "Article Contents"
---

## 🧩 The Situation

I had a working build from six hours ago. But after a flurry of local experiments and edits, I found myself in a tangled mess of changes, errors, and untracked files.

I wanted a clean slate, but I also didn’t want to lose the ideas and partial work I’d explored.

Sound familiar? This is one of those real-world Git moments where theory meets panic — and experience begins.

---

## 😰 The Problem

- A lot of uncommitted and untracked changes.
- Multiple edits across files, unclear which ones were still useful.
- Errors creeping into my local build.
- No recent backup branch.  
- Fear of losing something valuable in the cleanup process.

---

## 🎯 The Goal

- Revert to the last known **clean working commit**.
- Avoid losing any useful progress.
- Get back into a calm, focused state for development.

---

## ✅ The Solution: Backup Before You Nuke

Instead of resetting blindly or stashing everything temporarily, I went with the **safest and cleanest option**: creating a **backup branch** before resetting.

Here’s exactly what I did:

---

### 🌿 Step 1: Create a backup branch

```bash
git checkout -b backup-changes-apr20
```

This preserved *all current changes* in a dedicated branch.

---

### 💾 Step 2: Commit everything

```bash
git add .
git commit -m "WIP: Backup of work before reset on Apr 20"
```

Even half-baked code is safer when committed. It becomes traceable, restorable, and searchable later.

---

### 🔄 Step 3: Switch back to `main`

```bash
git checkout main
```

---

### 🧹 Step 4: Reset and clean up

```bash
git reset --hard
git clean -fd
```

Now my working directory was exactly as it was in the last clean commit. No more mess, no more fear.

---

### ☁️ Step 5 (Optional but Recommended): Push the backup

```bash
git push origin backup-changes-apr20
```

Because GitHub doesn’t crash when your laptop does 😉

---

## 💡 What I Learned

---

### 🛑 Why You Should *Never* Work Directly on `main`

In the moment, it feels easier to just edit what's there. But working directly on `main` led to:

- Confusion about which changes mattered.
- No clear safety net if something went wrong.
- Stress when I needed to clean things up.

> 🔁 Lesson: **Main is your production branch. Treat it that way.**

---

### ✅ A Better Git Workflow (That I Now Follow)

From now on, I always:

```bash
git checkout -b feature-[name]
```

- Do all my work in a dedicated feature or experiment branch.
- Commit frequently (even WIP commits).
- Merge to `main` only when it’s clean, tested, and intentional.

---

### 🧠 Git is More Than a Version Control Tool

This experience reminded me:

> Git is not just about saving code — it’s about organizing **your thinking**, **your risk**, and **your recovery plan**.

Resetting doesn’t have to mean *losing*. With a little care, it becomes part of a thoughtful development rhythm.

---

## 🌱 What I Learned (DevSecOps Mindset)

This wasn't just about Git commands. It was about building a **mental safety net**:

- That working clean doesn’t mean working recklessly.
- That backups are not weakness — they’re wisdom.
- That even in version control, **governance and rollback strategies** matter.

---

## 🧠 Final Reflection

> Git is not just for version control. It’s for version **confidence**.

By backing up before resetting, I avoided loss, confusion, and panic — and I gained a cleaner project and clearer mind.

> This is DevSecOps in practice: backup, rollback, safety, and governance — even at the developer level.

---

## 🧹 Git Cleanup Checklist

- ✅ Created backup branch: `backup-changes-apr20`
- ✅ Committed all changes with context
- ✅ Reset `main` to clean state
- ✅ Cleaned untracked files
- ✅ Pushed backup branch to GitHub for extra safety

---

*Thanks for reading. May your commits be clean, your merges be conflict-free, and your backups always be one step ahead!*

🔗 Explore more projects and secure Git workflows at [opsbygandal.dev](https://www.opsbygandal.dev)  \
or browse my GitHub repos: [https://github.com/gandalops?tab=repositories](https://github.com/gandalops?tab=repositories)  
🔄 Feedback? Let’s connect on [LinkedIn](https://www.linkedin.com/)

---