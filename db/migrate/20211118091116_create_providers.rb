class CreateProviders < ActiveRecord::Migration[6.1]
  # frozen_string_literal: true
  def change
    create_table :providers do |t|
      t.string :uid
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
