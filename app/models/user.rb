class User < ApplicationRecord
  validates :name, :surname, :patronymic, :position, presence: true
  has_secure_password
  has_and_belongs_to_many :docs
  has_many :matches, dependent: :destroy
  has_many :users, through: :matches
  belongs_to :subdivision

  def name_with_initial
    "#{surname} #{name.first}. #{patronymic.first}."
  end

  def name_with_patronymic
    "#{name} #{patronymic}"
  end

end
