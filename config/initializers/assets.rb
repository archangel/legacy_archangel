# frozen_string_literal: true

Rails.application.config.assets.precompile += [
  "*.gif", "*.ico", "*.jpeg", "*.jpg", "*.png",
  "*.eot", "*.svg", "*.ttf", "*.woff", "*.woff2",
  "admin.css", "admin.js",
  "auth.css", "auth.js",
  "frontend.css", "frontend.js"
]
