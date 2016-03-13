unless defined?(Archangel::Generators::InstallGenerator)
  require "generators/archangel/install/install_generator"
end

require "generators/archangel/dummy/dummy_generator"

desc "Generates a dummy app for testing"
namespace :dummy do
  task :generate do |t, args|
    ENV["RAILS_ENV"] = "test"

    Archangel::Generators::DummyGenerator.start [
      "--lib_name=#{ENV["LIB_NAME"]}",
      "--quiet"
    ]

    Archangel::Generators::InstallGenerator.start [
      "--auto-accept",
      "--skip-migrate",
      "--skip-sample",
      "--skip-seed",
      "--skip-turbolinks",
      "--route-path=archangel",
      "--quiet"
    ]

    puts "Setting up dummy database..."
    system("bundle exec rake db:drop db:create db:migrate > #{File::NULL}")

    unless ENV["LIB_NAME"] == "archangel"
      begin
        require "generators/#{ENV["LIB_NAME"]}/install/install_generator"

        puts "Running extension installation generator..."

        "#{ENV["LIB_NAME"].camelize}::Generators::InstallGenerator".
          constantize.
          start([
            "--auto-run-migrations",
            "--auto-accept",
            "--migrate",
            "--skip-sample",
            "--skip-seed",
            "--skip-turbolinks",
            "--route-path=archangel",
            "--quiet"
          ])
      rescue LoadError
        puts "Skipping extension install. No generator to run..."
      end
    end

    puts "Done."
  end
end
