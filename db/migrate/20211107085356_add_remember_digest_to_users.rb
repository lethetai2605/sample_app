# migrate
class AddRememberDigestToUsers < ActiveRecord::Migration[6.1]
  # frozen_string_literal: true
  def change
    add_column :users, :remember_digest, :string
  end
end
