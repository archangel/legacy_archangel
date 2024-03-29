# frozen_string_literal: true

module Archangel
  module Command
    # Generate Archangel extension
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class Extension < Thor::Group
      include Thor::Actions

      source_root File.expand_path("../templates/extension", __FILE__)

      desc "Build an Archangel extension"
      argument :file_name, type: :string,
                           desc: "Extension name",
                           default: "unknown"

      # Generate extension
      #
      # = Usage
      #   bundle exec bin/archangel extension [extension_name]
      #
      def generate
        extension_prefix "archangel_"

        empty_directory file_name

        %w[app bin config lib spec].each do |dir|
          directory dir, "#{file_name}/#{dir}"
        end

        template "extension.gemspec", "#{file_name}/#{file_name}.gemspec"

        %w[.editorconfig .gitignore .rspec .rubocop.yml Gemfile MIT-LICENSE
           Rakefile README.md].each do |tpl|
          template tpl, "#{file_name}/#{tpl}"
        end
      end

      # Banner
      #
      # Say something nice
      #
      def banner
        puts "*" * 80
        puts "  Your extension has been generated with a gemspec dependency on"
        puts "  Archangel #{archangel_version}."
        puts ""
        puts "  You look lovely today by the way."
        puts "*" * 80
      end

      no_tasks do
        def class_name
          Thor::Util.camel_case file_name
        end

        def archangel_version
          Archangel::VERSION
        end

        def extension_prefix(prefix)
          extension_name = file_name.downcase

          unless extension_name =~ /^#{prefix}/
            extension_name = prefix + extension_name
          end

          @file_name = Thor::Util.snake_case(extension_name)
        end
      end
    end
  end
end
