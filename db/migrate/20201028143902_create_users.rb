class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password
      t.integer :rating_count, default: 0
      t.integer :rating, default: 0
      t.string :bio, default: "Fill in some information about yourself!"

      t.timestamps
    end
  end
end
