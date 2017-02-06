module Archangel
  # MenuItem model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class MenuItem < ApplicationRecord
    extend ActsAsTree::TreeView

    acts_as_tree order: :position
    acts_as_paranoid

    # Callbacks
    after_initialize :column_default

    # Validation
    # validates :menu_id, presence: true
    validates :label, presence: true
    validates :method, allow_blank: true,
                       inclusion: { in: Archangel::MENU_METHODS }
    validates :url, url: true, allow_blank: true

    # Associations
    belongs_to :menu
    belongs_to :menuable, polymorphic: true
    belongs_to :parent, class_name: Archangel::MenuItem

    has_many :menu_items

    # Nested attributes
    accepts_nested_attributes_for :menu_items, reject_if: :all_blank,
                                               allow_destroy: true

    # Default scope
    default_scope { order(position: :asc) }

    # Scope
    scope :children, -> { where(parent_id: self.id) }

    protected

    def column_default
      self.method ||= Archangel::MENU_METHOD_DEFAULT
    end
  end
end
