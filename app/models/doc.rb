class Doc < ApplicationRecord
  include ImageUploader[:image]
  before_create :set_params
  after_create :check_matched_docs
  validates :title, :text, presence: true
  belongs_to :executor, class_name: "User"
  belongs_to :initiator, class_name: "User"
  belongs_to :signer, class_name: "User"
  belongs_to :destination, class_name: "User"
  has_and_belongs_to_many :users
  has_many :matches
  has_many :matchers, through: :matches, source: :user

  def set_params
    if Doc.last
      last_doc = Doc.last.id
    else
      last_doc = 0
    end
    self.number = sprintf("%03d", last_doc+1) + '-055'
    self.signed, self.agreed, self.done = false, false, false
  end
end
