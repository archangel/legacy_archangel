module Archangel
  module Admin
    module AdminHelper
      def author_link(author)
        author ||= Archangel::NullUser.new

        return Archangel.t(:unknown) if author.nil?

        link = admin_user_path(author)

        link = admin_profile_path if author == current_user

        link_to(author.name, link)
      end

      def datepicker_field_value(date, now = false)
        date_field_value(date,
                         Archangel.t(:format, scope: :datetimepicker),
                         now)
      end

      def datetimepicker_field_value(date, now = false)
        date_field_value(date,
                         Archangel.t(:time_format, scope: :datetimepicker),
                         now)
      end

      def date_field_value(date, format, now = false)
        date ||= Time.current if now

        return nil if date.blank?

        l(date, format: format)
      end
    end
  end
end
