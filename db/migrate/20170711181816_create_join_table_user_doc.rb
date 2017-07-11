class CreateJoinTableUserDoc < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :docs do |t|
      t.index [:user_id, :doc_id]
      t.index [:doc_id, :user_id]
    end
  end
end
