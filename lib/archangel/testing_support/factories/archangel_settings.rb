FactoryGirl.define do
  factory :setting, aliases: [:settings], class: Archangel::Setting do
    title "Archangel"
    per_page 24
  end
end
