class AddLockTimeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :lock_time, :datetime
  end
end
