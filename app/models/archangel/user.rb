module Archangel
  class User < ApplicationRecord
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
    validates :username, presence: true, uniqueness: true

    def to_param
      username
    end

    protected

    def parameterize_username
      self.username = username.to_s.downcase.parameterize
    end

    def column_reset
      self.email = "#{Time.current.to_i}_#{email}"
      self.username = "#{Time.current.to_i}_#{username}"

      save
    end
  end
end
