FactoryGirl.define do
  factory :site, class: Archangel::Site do
    name "Archangel"
    meta_keywords "very, useful, keywords"
    meta_description "This is the default description of the site."

    trait :logo do
      logo { File.new(uploader_test_image) }
    end
  end
end
