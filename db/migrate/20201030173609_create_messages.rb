class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :message
      t.belongs_to :user
      t.belongs_to :conversation

      t.timestamps
    end
  end
end
