# migrate
class AddIndexToUsersEmail < ActiveRecord::Migration[6.1]
  # frozen_string_literal: true
  def change
    add_index :users, :email, unique: true
  end
end
