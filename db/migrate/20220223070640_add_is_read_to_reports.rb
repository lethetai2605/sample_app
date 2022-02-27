class AddIsReadToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :is_read, :boolean, default: false
  end
end
