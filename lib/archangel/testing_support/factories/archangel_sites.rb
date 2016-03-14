FactoryGirl.define do
  factory :site, aliases: [:settings], class: Archangel::Site do
    title "Archangel"

    trait :logo do
      logo { File.new(uploader_test_file) }
    end
  end
end
