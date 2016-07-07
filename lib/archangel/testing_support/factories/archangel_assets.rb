FactoryGirl.define do
  factory :asset, class: Archangel::Asset do
    association :assetable, factory: :page
    uploader
  end
end
