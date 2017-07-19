class Match < ApplicationRecord
  belongs_to :user
  belongs_to :doc
  after_save :check_matched_docs

    def check_matched_docs
      Doc.all.each do |doc|
        doc.agreed = true if !(Match.where(doc_id: doc.id, match: false ).any?)
        doc.save
      end
    end
end
