---
layout: home
title: "Welcome to My DevSecOps Portfolio"
author_profile: true
permalink: /
sidebar:
  show_recent: true   # Enables the Recent Posts sidebar
  recent_limit: 3     # Shows 3 most recent posts
  nav: "main"         # Links to your main navigation
feature_row:
  - title: "About Me"
    excerpt: "My journey from academia to DevSecOps"
    url: "/about/"
    btn_class: "btn--primary"
    btn_label: "Learn More"
  - title: "Projects"
    excerpt: "View my technical projects"
    url: "/projects/"
    btn_class: "btn--primary"
    btn_label: "See Projects"
  - title: "Blog"
    excerpt: "Read my latest articles"
    url: "/blog/"
    btn_class: "btn--primary"
    btn_label: "Visit Blog"
---

{% include home-content.html %}

<style>
  /* Custom ordering for sections */
  .page__content {
    display: flex;
    flex-direction: column;
  }
  
  /* Ensure proper spacing */
  .feature__wrapper {
    margin-bottom: 2em;
  }
</style>
