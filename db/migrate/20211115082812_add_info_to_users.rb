# migrate
class AddInfoToUsers < ActiveRecord::Migration[6.1]
  # frozen_string_literal: true
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end
end
