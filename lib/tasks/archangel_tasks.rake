namespace :archangel do
  desc "Current Archangel version"
  task :version do
    puts Archangel::VERSION
  end
end
