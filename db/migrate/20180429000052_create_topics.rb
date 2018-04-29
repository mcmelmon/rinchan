class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.text :subject
      t.boolean :anonymous, default: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
    add_index :topics, [:user_id, :created_at]

    create_table :replies do |t|
      t.text :body
      t.boolean :anonymous, default: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :topic, foreign_key: true

      t.timestamps
    end
    add_index :replies, [:user_id, :created_at]
    add_index :replies, [:topic_id, :created_at]

    create_table :tags do |t|
      t.string :name
      t.belongs_to :user, foreign_key: true
      t.belongs_to :topic, foreign_key: true

      t.timestamps
    end
    add_index :tags, [:user_id, :created_at]
    add_index :tags, [:topic_id, :created_at]

    create_table :objections do |t|
      t.string :body
      t.belongs_to :user, foreign_key: true
      t.belongs_to :topic, foreign_key: true

      t.timestamps
    end
    add_index :objections, [:user_id, :created_at]
    add_index :objections, [:topic_id, :created_at]
  end
end
