# frozen_string_literal: true
# ruby encoding: utf-8

require "highline/import"

def prompt_for_admin_email
  ENV.fetch("ADMIN_EMAIL") do
    ask("Email address:  ") do |question|
      question.default = "archangel@example.com"
    end
  end
end

def prompt_for_admin_name
  ENV.fetch("ADMIN_NAME") do
    ask("Name:  ") { |question| question.default = "Archangel User" }
  end
end

def prompt_for_admin_password
  ENV.fetch("ADMIN_PASWORD") do
    ask("Password:  ") { |question| question.echo = "*" }
  end
end

def prompt_for_admin_username
  ENV.fetch("ADMIN_USERNAME") do
    ask("Username:  ") { |question| question.default = "administrator" }
  end
end

# Site
Archangel::Site.first_or_create! do |item|
  item.name = "Archangel"
  item.locale = "en"
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
page = Archangel::Page.published.find_or_create_by!(homepage: true) do |item|
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

# Menu
menu = Archangel::Menu.find_or_create_by!(slug: "frontend") do |item|
  item.name = "Frontend Menu"
end

# Menu Item
Archangel::MenuItem.where(menu_id: menu.id).first_or_create! do |item|
  item.label = page.title
  item.menuable = page
end
