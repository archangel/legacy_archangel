# ruby encoding: utf-8

require "highline/import"

unless Archangel::User.first
  email = ask("Email address:  ") { |q| q.default = "me@example.com" }
  username = ask("Username:  ") { |q| q.default = "admin" }
  name = ask("Name:  ") { |q| q.default = "Admin" }
  password = ask("Password:  ") { |q| q.echo = "*" }

  Archangel::User.create!(email: email,
                          username: username,
                          name: name,
                          password: password,
                          password_confirmation: password,
                          role: "admin",
                          confirmed_at: Time.current)
end

# Pages
Archangel::Page.find_or_create_by!(path: "") do |item|
  item.title = "Welcome"
  item.content = "Welcome to your new site."
  item.author_id = Archangel::User.first.id
  item.published_at = Time.current
end
