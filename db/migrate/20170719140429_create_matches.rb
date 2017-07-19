class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.references :user, foreign_key: true
      t.references :doc, foreign_key: true
      t.boolean :match, default: false

      t.timestamps
    end
  end
end
