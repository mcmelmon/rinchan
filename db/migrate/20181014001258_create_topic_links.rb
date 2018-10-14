class CreateTopicLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :topic_links do |t|
      t.string :url
      t.string :title
      t.string :image_url
      t.string :description
      t.belongs_to :parent
      t.string :parent_type

      t.timestamps
    end
  end
end
