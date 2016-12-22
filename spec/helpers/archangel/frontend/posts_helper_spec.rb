require "rails_helper"

module Archangel
  module Frontend
    RSpec.describe PostsHelper, type: :helper do
      context "#author_link(obj)" do
        let(:post) { create(:post) }

        it "builds author profile link" do
          expected = link_to(post.author.name, "#")

          expect(helper.author_link(post)).to eq(expected)
        end
      end

      context "#posted_at(obj)" do
        let(:post) { create(:post) }

        it "builds posted at time for post" do
          post_date = post.published_at.strftime("%B %e, %Y at %l:%M %p")
          post_datetime = post.published_at.strftime("%FT%T%:z")

          expected = content_tag(:time,
                                 post_date,
                                 pubdate: "",
                                 datetime: post_datetime)

          expect(helper.posted_at(post)).to eq(expected)
        end
      end

      context "#post_path(obj)" do
        let(:post) { create(:post) }

        it "build local path to post" do
          expected = "/#{Archangel.configuration.posts_path}/#{post.path}"

          expect(helper.post_path(post)).to eq(expected)
        end
      end

      context "#post_url(obj)" do
        let(:post) { create(:post) }

        it "build URL to post" do
          expected = "#{Archangel.configuration.posts_path}/#{post.path}"

          expect(helper.post_url(post)).to end_with(expected)
        end
      end
    end
  end
end
