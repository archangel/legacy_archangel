FactoryGirl.define do
  factory :asset, class: Archangel::Asset do
    association :assetable, factory: :page
    uploader
    title "Asset File"
    file { fixture_file_upload(uploader_test_image) }

    trait :text_file do
      file { fixture_file_upload(uploader_test_text) }
    end
  end
end
