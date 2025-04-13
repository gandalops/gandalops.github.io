source "https://rubygems.org"

# Core Jekyll + GitHub Pages
gem "github-pages", "~> 232", group: :jekyll_plugins

# Additional required gems to resolve warnings/errors
gem "faraday-retry"                      # Resolves the Faraday v2.0+ warning
gem "webrick", "~> 1.7"                  # Often needed for local Jekyll serving
gem "jekyll-remote-theme"                # Explicitly include if using mmistakes theme

group :jekyll_plugins do
  gem "jekyll-feed"                      # For RSS feed
  gem "jekyll-seo-tag"                   # For better SEO
  gem "jekyll-sitemap"                   # For sitemap generation
end