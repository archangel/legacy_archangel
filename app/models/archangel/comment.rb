module Archangel
  class Comment < ApplicationRecord
    acts_as_paranoid

    # Validation
    validates :approved_at, allow_blank: true, date: true
    validates :email, allow_blank: true, email: true
    validates :message, presence: true

    # Associations
    belongs_to :author, class_name: Archangel::User
    belongs_to :commentable, polymorphic: true
    belongs_to :parent, class_name: Archangel::Comment, foreign_key: :parent_id

    has_many :children, class_name: Archangel::Comment, foreign_key: :parent_id

    # Scope
    scope :unapproved, -> { where(approved_at: nil) }
    scope :for_source, ->(source) { where(commentable: source) }
  end
end
