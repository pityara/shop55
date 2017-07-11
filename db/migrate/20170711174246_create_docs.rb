class CreateDocs < ActiveRecord::Migration[5.1]
  def change
    create_table :docs do |t|
      t.string :title
      t.text :text
      t.string :number
      t.text :logs
      t.boolean :signed
      t.boolean :agreed
      t.text :resolution
      t.boolean :done
      t.references :initiator, index: true, foreign_key: { to_table: :users }
      t.references :destination, index: true, foreign_key: { to_table: :users }
      t.references :signer, index: true, foreign_key: { to_table: :users }
      t.references :executor, index: true, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
