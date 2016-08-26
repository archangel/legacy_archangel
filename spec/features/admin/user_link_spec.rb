require "rails_helper"

RSpec.feature "User links", type: :feature do
  describe "with valid user" do
    before { stub_authorization! }

    it "shows author name and links to User" do
      author = create(:user)
      create(:page, author: author)

      visit archangel.admin_pages_path

      within_row(1) do
        expect(page).to have_link(author.name,
                                  href: archangel.admin_user_path(author))
      end
    end
  end

  describe "with current user" do
    let!(:author) { create(:user) }

    before { stub_authorization! author }

    it "shows author name and links to current profile" do
      create(:page, author: author)

      visit archangel.admin_pages_path

      within_row(1) do
        expect(page).to have_link(author.name,
                                  href: archangel.admin_profile_path)
      end
    end
  end

  describe "without valid User" do
    before { stub_authorization! }

    it "does not show author name, does not link to author" do
      create(:page, author_id: 1234)

      visit archangel.admin_pages_path

      within_row(1) { expect(page).to have_content Archangel.t(:unknown) }
    end
  end
end
