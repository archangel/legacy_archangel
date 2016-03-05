module Archangel
  class Railtie < Rails::Railtie
    railtie_name :archangel

    rake_tasks do
      load "tasks/archangel_tasks.rake"
    end
  end
end
