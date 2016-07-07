# ruby encoding: utf-8

require "highline/import"

user = Archangel::User.first

unless user
  email = ask("Email address:  ") { |q| q.default = "me@example.com" }
  username = ask("Username:  ") { |q| q.default = "archangel" }
  name = ask("Name:  ") { |q| q.default = "Archangel" }
  password = ask("Password:  ") { |q| q.echo = "*" }

  user = Archangel::User.create!(email: email,
                                 username: username,
                                 name: name,
                                 password: password,
                                 password_confirmation: password,
                                 confirmed_at: Time.current)
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
Archangel::Page.find_or_create_by!(path: "home", slug: "home") do |item|
  item.title = "Welcome"
  item.content = "Welcome to your new site."
  item.author_id = user.id
  item.published_at = Time.current
end
