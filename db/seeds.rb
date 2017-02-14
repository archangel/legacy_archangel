# frozen_string_literal: true
# ruby encoding: utf-8

require "highline/import"

def prompt_for_admin_email
  ENV.fetch("ADMIN_EMAIL") do
    ask("Email address:  ") { |q| q.default = "archangel@example.com" }
  end
end

def prompt_for_admin_name
  ENV.fetch("ADMIN_NAME") do
    ask("Name:  ") { |q| q.default = "Archangel User" }
  end
end

def prompt_for_admin_password
  ENV.fetch("ADMIN_PASWORD") do
    ask("Password:  ") { |q| q.echo = "*" }
  end
end

def prompt_for_admin_username
  ENV.fetch("ADMIN_USERNAME") do
    ask("Username:  ") { |q| q.default = "password123" }
  end
end

# User
user = Archangel::User.first

unless user
  email    = prompt_for_admin_email
  username = prompt_for_admin_username
  name     = prompt_for_admin_name
  password = prompt_for_admin_password

  attributes = {
    email: email,
    username: username,
    name: name,
    password: password,
    password_confirmation: password,
    confirmed_at: Time.current
  }

  user = Archangel::User.create!(attributes)
end

# Tags
Archangel::Tag.find_or_create_by!(slug: "unknown") do |item|
  item.name = "Unknown"
end

# Categories
Archangel::Category.find_or_create_by!(slug: "unknown") do |item|
  item.name = "Unknown"
end

# Pages
Archangel::Page.published.find_or_create_by!(homepage: true) do |item|
  item.slug = "homepage-#{Time.now.to_i}"
  item.title = "Welcome"
  item.content = "<p>Welcome to your new site.</p>"
  item.author_id = user.id
  item.published_at = Time.current
end

# Posts
unless Archangel::Post.published.any?
  Archangel::Post.create(title: "First Post",
                         slug: "first-post",
                         author_id: Archangel::User.first.id,
                         content: "This is the body of the very first post.",
                         published_at: Time.current)
end
