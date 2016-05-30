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
                                 role: "admin",
                                 confirmed_at: Time.current)
end

# Pages
Archangel::Page.find_or_create_by!(path: "home", slug: "home") do |item|
  item.title = "Welcome"
  item.content = "Welcome to your new site."
  item.author_id = user.id
  item.published_at = Time.current
end

# Posts
unless Archangel::Post.first
  Archangel::Post.create!(title: "First Post",
                          slug: "Welcome to your new site.",
                          author_id: user.id,
                          content: "This is the first post.",
                          published_at: Time.current)
end
