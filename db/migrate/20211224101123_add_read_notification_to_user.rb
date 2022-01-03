class AddReadNotificationToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :read_notification, :boolean, default: false
  end
end
