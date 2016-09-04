FactoryGirl.define do
  factory :asset, class: Archangel::Asset do
    association :assetable, factory: :page
    uploader
    title "Asset File"
    file { File.new(uploader_test_image) }

    trait :text_file do
      file { File.new(uploader_test_text) }
    end
  end
end
