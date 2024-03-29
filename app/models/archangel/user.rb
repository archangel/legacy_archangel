# frozen_string_literal: true

module Archangel
  # User model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class User < ApplicationRecord
    acts_as_paranoid

    before_validation :parameterize_username

    after_initialize :column_default

    after_destroy :column_reset

    devise :confirmable, :database_authenticatable, :invitable, :lockable,
           :recoverable, :registerable, :rememberable, :timeoutable, :trackable,
           :validatable

    mount_uploader :avatar, Archangel::AvatarUploader

    validates :avatar, file_size: {
      less_than_or_equal_to: Archangel.config.image_maximum_file_size
    }
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

    # Override column ActionPack uses for constructing the URL to this object
    #
    def to_param
      username
    end

    protected

    def parameterize_username
      self.username = username.to_s.downcase.parameterize
    end

    def column_default
      self.role ||= Archangel::ROLE_DEFAULT
    end

    def column_reset
      now = Time.current.to_i

      self.email = "#{now}_#{email}"
      self.username = "#{now}_#{username}"

      save
    end
  end
end
