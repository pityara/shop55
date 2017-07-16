class AddRefusedInDocs < ActiveRecord::Migration[5.1]
  def change
    add_column :docs, :refused, :boolean, default: false
  end
end
