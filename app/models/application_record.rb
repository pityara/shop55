class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
    def check_matched_docs
      Doc.where(agreed: false).each do |doc|
        doc.agreed = true if Match.where(doc_id: doc.id, match: false ).empty?
        doc.save
      end
    end
end
