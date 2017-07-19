class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_secure_password
  has_and_belongs_to_many :docs
  has_many :matches
  has_many :users, through: :matches
end
