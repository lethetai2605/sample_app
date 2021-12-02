class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
    add_index :reactions, :name, unique: true
  end
end
