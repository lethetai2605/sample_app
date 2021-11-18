# migrate
class AddPasswordDigestToUsers < ActiveRecord::Migration[6.1]
  # frozen_string_literal: true
  def change
    add_column :users, :password_digest, :string
  end
end
