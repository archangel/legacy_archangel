# frozen_string_literal: true

FactoryGirl.define do
  factory :category, class: Archangel::Category do
    sequence(:name) { |n| "Category #{n}" }
    sequence(:slug) { |n| "category-#{n}" }
    description "Description for category"
  end
end
