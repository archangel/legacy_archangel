module Archangel
  class User < ActiveRecord::Base
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
    validates :name, presence: true
    validates :password, presence: true,
                         length: { minimum: 8, maximum: 72 },
                         on: :create
    validates :password, allow_blank: true,
                         length: { minimum: 8, maximum: 72 },
                         on: :update
    validates :role, presence: true, inclusion: { in: Archangel::ROLES }
    validates :username, presence: true, uniqueness: true

    def to_param
      username
    end

    # Methods
    def self.user?
      role?(:user) || !Archangel::ROLES.include?(role.downcase)
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
      self.email = "#{Time.current.to_i}_#{email}"
      self.username = "#{Time.current.to_i}_#{username}"
      self.save
    end
  end
end
