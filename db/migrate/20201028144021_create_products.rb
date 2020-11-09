class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.string :description
      t.string :category_one
      t.string :category_two
      t.string :category_three
      t.string :categories, array: true, default: []
      t.boolean :sold, default: false
      t.boolean :rated, default: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
