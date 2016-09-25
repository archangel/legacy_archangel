module Archangel
  module BaseHelper
    def locale
      Archangel::Site.current.locale || Archangel::LANGUAGE_DEFAULT
    end

    def text_direction
      Archangel::RTL_LANGUAGES.include?(locale) ? "rtl" : "ltr"
    end
  end
end
