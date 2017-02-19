# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Account login page", type: :feature do
  describe "when on registration page" do
    it "has additional form fields" do
      visit archangel.new_user_registration_path

      expect(page).to have_text "Name"
      expect(page).to have_text "Username"

      expect(page).to have_selector("input[type=text][id='user_name']")
      expect(page).to have_selector("input[type=text][id='user_username']")
    end
  end
end
