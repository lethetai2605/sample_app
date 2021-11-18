# migrate
class AddAdminToUsers < ActiveRecord::Migration[6.1]
  # frozen_string_literal: true
  def change
    add_column :users, :admin, :boolean, default: false
  end
end
