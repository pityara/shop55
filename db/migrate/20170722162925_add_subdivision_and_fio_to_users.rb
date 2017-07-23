class AddSubdivisionAndFioToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :surname, :string
    add_column :users, :patronymic, :string
    add_column :users, :position, :string
    add_reference :users, :subdivision
  end
end
