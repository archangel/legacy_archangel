module Archangel
  # Application helpers
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  module ApplicationHelper
    # Site locale
    #
    # = Example
    #   "<%= locale %>" #=> "en"
    #
    # @return [String] site locale
    #
    def locale
      Archangel::Site.current.locale || Archangel::LANGUAGE_DEFAULT
    end

    # Text direction based on locale
    #
    # = Example
    #   "<%= text_direction %>" #=> "ltr"
    #
    # @return [String] text direction
    #
    def text_direction
      Archangel::RTL_LANGUAGES.include?(locale) ? "rtl" : "ltr"
    end
  end
end
