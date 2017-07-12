class AddAttachToDocs < ActiveRecord::Migration[5.1]
  def change
    add_column :docs, :image_data, :text
  end
end
