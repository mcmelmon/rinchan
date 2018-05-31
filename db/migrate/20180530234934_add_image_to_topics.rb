class AddImageToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :image, :string
  end
end
