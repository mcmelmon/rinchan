class CreateBulletins < ActiveRecord::Migration[5.2]
  def change
    create_table :bulletins do |t|
      t.text :body
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
    add_index :bulletins, [:user_id, :created_at]

    create_table :comments do |t|
      t.text :body
      t.belongs_to :user, foreign_key: true
      t.belongs_to :bulletin, foreign_key: true

      t.timestamps
    end
    add_index :comments, [:user_id, :created_at]
    add_index :comments, [:bulletin_id, :created_at]
  end
end
