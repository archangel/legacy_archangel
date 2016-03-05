module Archangel
  class User < ActiveRecord::Base
    extend FriendlyId

    friendly_id :username

    acts_as_paranoid

    # Callbacks
    before_validation :parameterize_username
    after_destroy :column_reset

    # Devise
    devise :database_authenticatable, :invitable, :recoverable, :registerable,
           :lockable, :rememberable, :trackable, :validatable, :confirmable,
           :timeoutable

    # Uploader
    mount_uploader :avatar, Archangel::AvatarUploader

    # Validation
    validates :email, presence: true, uniqueness: true, email: true
    validates :name, presence: true, allow_blank: true
    validates :password, presence: true,
                         length: { minimum: 5, maximum: 120 },
                         on: :create
    validates :password, allow_blank: true,
                         length: { minimum: 5, maximum: 120 },
                         on: :update
    validates :role, presence: true, inclusion: { in: Archangel::ROLES }
    validates :username, presence: true, uniqueness: true

    # Default scope
    default_scope { order(name: :asc, username: :asc, email: :asc) }

    # Methods
    def self.user?
      role?(:user) || !Archangel::ROLES.include?(role.downcase)
    end

    def self.manager?
      role? :manager
    end

    def self.admin?
      role? :admin
    end

    def self.role?(role_type)
      role.downcase == role_type.to_s.downcase
    end

    protected

    def parameterize_username
      self.username = username.to_s.downcase.parameterize
    end

    def column_reset
      update_attributes(email: "#{Time.current.to_i}_#{email}",
                        username: "#{Time.current.to_i}_#{username}")
    end
  end
end
