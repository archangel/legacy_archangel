# frozen_string_literal: true

module Archangel
  # Admin helpers
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  module AdminHelper
    include FontAwesome::Rails::IconHelper

    def author_link(author)
      author ||= Archangel::User.new

      return Archangel.t(:unknown) unless author.persisted?

      link = archangel.admin_user_path(author)

      link = archangel.admin_profile_path if author == current_user

      link_to(author.name, link)
    end

    def datepicker_field_value(date, now = false)
      date_field_value(date,
                       Archangel.t(:date_format, scope: :datetimepicker),
                       now)
    end

    def timepicker_field_value(date, now = false)
      date_field_value(date,
                       Archangel.t(:time_format, scope: :datetimepicker),
                       now)
    end

    def datetimepicker_field_value(date, now = false)
      date_field_value(date,
                       Archangel.t(:format, scope: :datetimepicker),
                       now)
    end

    def date_field_value(date, format, now = false)
      date ||= Time.current if now

      return nil if date.blank?

      l(date, format: format)
    end
  end
end
