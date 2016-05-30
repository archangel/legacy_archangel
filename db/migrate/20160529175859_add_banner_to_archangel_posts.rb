class AddBannerToArchangelPosts < ActiveRecord::Migration
  def change
    add_column :archangel_posts, :banner, :string
  end
end
