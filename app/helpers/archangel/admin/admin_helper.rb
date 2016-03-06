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
    end
  end
end
