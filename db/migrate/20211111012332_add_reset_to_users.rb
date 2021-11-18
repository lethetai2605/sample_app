# migrate
class AddResetToUsers < ActiveRecord::Migration[6.1]
  # frozen_string_literal: true
  def change
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datetime
  end
end
