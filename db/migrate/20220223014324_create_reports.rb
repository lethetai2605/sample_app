class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :reported_id
      t.integer :reporter_id
      t.string :reason

      t.timestamps
    end
    add_index :reports, [:reported_id, :reporter_id]
  end
end
