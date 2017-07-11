class Doc < ApplicationRecord
  before_save :set_params
  belongs_to :executor, class_name: "User"
  belongs_to :initiator, class_name: "User"
  belongs_to :signer, class_name: "User"
  belongs_to :destination, class_name: "User"
  has_and_belongs_to_many :users


  def set_params
    self.number = self.id.to_s + '-055'
  end
end
