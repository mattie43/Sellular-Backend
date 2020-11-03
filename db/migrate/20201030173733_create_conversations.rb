class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.integer :buyer
      t.integer :seller
      t.integer :product

      t.timestamps
    end
  end
end
