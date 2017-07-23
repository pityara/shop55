class CreateSubdivisions < ActiveRecord::Migration[5.1]
  def change
    create_table :subdivisions do |t|
      t.integer :number
      t.string :name

      t.timestamps
    end
  end
end
