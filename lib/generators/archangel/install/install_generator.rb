require "rails/generators"
require "highline/import"

module Archangel
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      class_option :admin_email, type: :string, desc: "Admin email address"
      class_option :admin_name, type: :string, desc: "Admin name"
      class_option :admin_password, type: :string, desc: "Admin password"
      class_option :admin_username, type: :string, desc: "Admin username"

      class_option :migrate, type: :boolean,
                             default: true,
                             desc: "Run database migrations"
      class_option :quiet, type: :boolean,
                           default: false,
                           desc: "Silence is golden"
      class_option :route_path, type: :string, default: "", desc: "Root path"
      class_option :seed, type: :boolean, default: false, desc: "Seed database"

      def create_assets
        say_quietly "Copying Archangel vendor assets..."

        %w(admin application auth).each do |section|
          copy_file "vendor/assets/javascripts/archangel/#{section}.js"
          copy_file "vendor/assets/stylesheets/archangel/#{section}.css"
        end
      end

      def add_env_file
        say_quietly "Copying sample .env file..."

        copy_file ".env.sample"
      end

      def add_initializers
        say_quietly "Copying initializers..."

        copy_file "config/initializers/archangel.rb"

        template "config/initializers/carrierwave.rb"
        template "config/initializers/devise.rb"
      end

      def create_local_seeds_file
        return unless options[:seed]

        return if File.exist?(File.join(destination_root, "db", "seeds.rb"))

        say_quietly "Creating db/seeds.rb..."

        create_file "db/seeds.rb"
      end

      def add_archangel_seed
        return unless options[:seed]

        say_quietly "Seeding local seeds.rb..."

        append_file "db/seeds.rb", verbose: true do
          <<-SEED
# Archangel seed data
Archangel::Engine.load_seed

          SEED
        end
      end

      def install_migrations
        say_quietly "Installing migrations..."

        silence_warnings { rake "railties:install:migrations" }
      end

      def create_database
        say_quietly "Creating database..."

        silence_warnings { rake "db:create" }
      end

      def run_migrations
        if options[:migrate]
          say_quietly "Running migrations..."

          silence_warnings { rake "db:migrate" }
        else
          say_quietly "Skipping migrations. Be sure to run `rake db:migrate` " \
                      "yourself."
        end
      end

      def seed_database
        if options[:migrate] && options[:seed]
          say_quietly "Inseminating..."

          silence_warnings { rake "db:seed #{rake_seed_options.join(" ")}" }
        else
          say_quietly "Skipping seed data. Run `rake db:seed` yourself."
        end
      end

      def insert_routes
        say_quietly "Adding Archangel routes..."

        insert_into_file File.join("config", "routes.rb"),
                         after: "Rails.application.routes.draw do\n" do
          <<-ROUTES
  # This mounts Archangel's routes at the root of your application. If you
  # would like to change where the engine is mounted, simply change the :at
  # option to reflect your needs.
  mount Archangel::Engine, at: "/#{options[:route_path]}"

            ROUTES
        end

        say_quietly "Your application's config/routes.rb has been updated."
      end

      def banner
        say_quietly "*" * 80
        say_quietly "  Done, sir! Done! Archangel has been installed!"
        say_quietly "*" * 80
      end

      protected

      def rake_seed_options
        [].tap do |collector|
          %w(admin_email admin_name admin_password admin_username).each do |opt|
            if options[opt.to_sym]
              collector << "#{opt.to_s.upcase}=#{options[opt.to_sym]}"
            end
          end
        end
      end

      def say_quietly(message)
        say message unless options[:quiet]
      end
    end
  end
end
