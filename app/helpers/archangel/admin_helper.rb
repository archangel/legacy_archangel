# frozen_string_literal: true

module Archangel
  # Admin helpers
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  module AdminHelper
    # Author link
    #
    # The current logged in user will link to the profile. All others will link
    # to the User.
    #
    # = Example
    #   "<%= author_link(resource.author) %>"
    #     #=> "admin_user_path(resource.author)"
    #   "<%= author_link(resource.author) %>"
    #     #=> "admin_profile_path # when current user"
    #
    # @param [Archangel::User] author
    #                          author resource
    # @return [String] link to user
    #
    def author_link(author)
      author ||= Archangel::User.new

      return Archangel.t(:unknown) unless author.persisted?

      link = archangel.admin_user_path(author)

      link = archangel.admin_profile_path if author == current_user

      link_to(author.name, link)
    end

    # Date picker field value
    #
    # Returns value in the format of `%Y-%m-%d`
    #
    # = Example
    #   "<%= datepicker_field_value(resource.published_at) %>"
    #   "<%= datepicker_field_value(resource.published_at, true) %>"
    #   "<%= datepicker_field_value(resource.published_at, false) %>"
    #
    # @param [Datetime] date
    #                   date object
    # @param [Boolean] now
    #                  use current time
    # @return [String] value for time picker
    #
    def datepicker_field_value(date, now = false)
      date_field_value(date,
                       Archangel.t(:date_format, scope: :datetimepicker),
                       now)
    end

    # Time picker field value
    #
    # Returns value in the format of `%H:%M`
    #
    # = Example
    #   "<%= timepicker_field_value(resource.published_at) %>"
    #   "<%= timepicker_field_value(resource.published_at, true) %>"
    #   "<%= timepicker_field_value(resource.published_at, false) %>"
    #
    # @param [Datetime] date
    #                   date object
    # @param [Boolean] now
    #                  use current time
    # @return [String] value for time picker
    #
    def timepicker_field_value(date, now = false)
      date_field_value(date,
                       Archangel.t(:time_format, scope: :datetimepicker),
                       now)
    end

    # Datetime picker field value
    #
    # Returns value in the format of `%Y-%m-%d %H:%M`
    #
    # = Example
    #   "<%= datetimepicker_field_value(resource.published_at) %>"
    #   "<%= datetimepicker_field_value(resource.published_at, true) %>"
    #   "<%= datetimepicker_field_value(resource.published_at, false) %>"
    #
    # @param [Datetime] date
    #                   date object
    # @param [Boolean] now
    #                  use current time
    # @return [String] value for datetime picker
    #
    def datetimepicker_field_value(date, now = false)
      date_field_value(date,
                       Archangel.t(:format, scope: :datetimepicker),
                       now)
    end

    # Date field value
    #
    # = Example
    #   "<%= date_field_value(resource.published_at, '%y%m%d') %>"
    #   "<%= date_field_value(resource.published_at, '%y%m%d', true) %>"
    #   "<%= date_field_value(resource.published_at, '%y%m%d', false) %>"
    #
    # @param [Datetime] date
    #                   date object
    # @param [String] format
    #                 date format
    # @param [Boolean] now
    #                  use current time
    # @return [String] value for date picker
    #
    def date_field_value(date, format, now = false)
      date ||= Time.current if now

      return nil if date.blank?

      l(date, format: format)
    end
  end
end
