# frozen_string_literal: true

require "rails/generators"
require "rails/generators/rails/app/app_generator"
require "active_support/core_ext/hash"

module Archangel
  module Generators
    # Dummy application generator
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class DummyGenerator < Rails::Generators::Base
      desc "Creates blank Rails application, installs Archangel"

      class_option :lib_name, default: "", desc: "Library name"
      class_option :database, default: "sqlite",
                              desc: "Type of database to use in dummy app."

      source_root File.expand_path("../templates", __FILE__)

      PASSTHROUGH_OPTIONS = %i[
        skip_active_record skip_javascript database javascript quiet pretend
        force skip
      ].freeze

      def prevent_application_dummy
        return unless Rails.respond_to?(:root) && !Rails.root.nil?

        abort "Dummy generator cannot be run outside Archangel extension."
      end

      def clean_up
        remove_directory_if_exists(dummy_path)
      end

      def generate_dummy
        opts = {}.merge(options).slice(*PASSTHROUGH_OPTIONS)

        opts[:database] = "sqlite3" if opts[:database].blank?
        opts[:force] = true
        opts[:skip_bundle] = true
        opts[:skip_git] = true
        opts[:old_style_hash] = false
        opts[:skip_turbolinks] = true

        puts "Generating dummy Rails application..."

        invoke Rails::Generators::AppGenerator,
               [File.expand_path(dummy_path, destination_root)],
               opts
      end

      def copy_dummy_config
        @lib_name = options[:lib_name]
        @database = options[:database]

        %w[config/database.yml].each do |tpl|
          template tpl, "#{dummy_path}/#{tpl}", force: true
        end
      end

      def test_default_url
        insert_into_file "#{dummy_path}/config/environments/test.rb",
                         after: "Rails.application.configure do\n" do
          <<-DEFAULT_URL
  config.action_mailer.default_url_options = { host: "localhost", port: 3000 }

  config.action_view.raise_on_missing_translations = true
            DEFAULT_URL
        end
      end

      def dummy_cleanup
        inside dummy_path do
          %w[.gitignore db/seeds.rb Gemfile lib/tasks public/robots.txt spec
             test vendor].each { |path| remove_file path }
        end
      end

      attr_reader :lib_name
      attr_reader :database

      protected

      def remove_directory_if_exists(path)
        remove_dir(path) if File.directory?(path)
      end

      def inject_require_for(requirement)
        inject_into_file "config/application.rb", %(
  begin
    require "#{requirement}"
  rescue LoadError
    # #{requirement} is not available.
  end
        ), before: /require "#{@lib_name}"/, verbose: true
      end

      def dummy_path
        ENV["DUMMY_PATH"] || "spec/dummy"
      end
    end
  end
end
