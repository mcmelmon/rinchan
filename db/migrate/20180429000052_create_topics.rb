class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.text :subject
      t.boolean :anonymous, default: true
      t.references :user, foreign_key: true

      t.timestamps
    end

    create_table :replies do |t|
      t.text :body
      t.boolean :anonymous, default: true
      t.belongs_to :user
      t.belongs_to :topic

      t.timestamps
    end

    add_index :topics, [:user_id, :created_at]
  end
end
