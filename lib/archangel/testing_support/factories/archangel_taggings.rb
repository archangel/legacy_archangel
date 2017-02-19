# frozen_string_literal: true

FactoryGirl.define do
  factory :tagging, class: Archangel::Tagging do
    tag
    association :taggable, factory: :page
  end
end
