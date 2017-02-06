FactoryGirl.define do
  factory :asset, class: Archangel::Asset do
    uploader
    association :assetable, factory: :page
    title "Asset File"
    file { fixture_file_upload(uploader_test_image) }

    trait :text_file do
      file { fixture_file_upload(uploader_test_text) }
    end
  end
end
