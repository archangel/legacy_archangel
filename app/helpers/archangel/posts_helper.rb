module Archangel
  module PostsHelper
    def path_to(post)
      post_year_month_post_path(post.published_at.year,
                                post.published_at.month,
                                post.slug)
    end
  end
end
