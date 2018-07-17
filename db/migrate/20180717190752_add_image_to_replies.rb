class AddImageToReplies < ActiveRecord::Migration[5.2]
  def change
    add_column :replies, :image, :string
  end
end
