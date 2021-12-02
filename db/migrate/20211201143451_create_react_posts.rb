class CreateReactPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :react_posts do |t|
      t.references :micropost, null: false, foreign_key: true
      t.references :reaction, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :react_posts, [:micropost_id, :user_id, :created_at]
  end
end
