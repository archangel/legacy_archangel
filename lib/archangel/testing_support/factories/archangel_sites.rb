# frozen_string_literal: true

FactoryGirl.define do
  factory :site, class: Archangel::Site do
    name "Archangel"
    meta_keywords %w(very useful keywords)
    meta_description "This is the default description of the site."

    trait :logo do
      logo { fixture_file_upload(uploader_test_image) }
    end
  end
end
