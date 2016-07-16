module Archangel
  module BaseHelper
    def locale
      Archangel::Site.current.locale || Archangel::LANGUAGE_DEFAULT
    end
  end
end
