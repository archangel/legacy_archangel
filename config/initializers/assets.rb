# frozen_string_literal: true

Rails.application.config.assets.precompile += [
  "*.gif", "*.jpeg", "*.jpg", "*.png",
  "*.eot", "*.svg", "*.ttf", "*.woff", "*.woff2",
  "archangel/default/admin.css", "archangel/default/admin.js",
  "archangel/default/auth.css", "archangel/default/auth.js",
  "archangel/default/frontend.css", "archangel/default/frontend.js"
]
