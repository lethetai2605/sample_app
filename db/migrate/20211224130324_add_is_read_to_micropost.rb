class AddIsReadToMicropost < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :is_read, :boolean, default: false
  end
end
