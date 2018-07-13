class AddOriginalToReplies < ActiveRecord::Migration[5.2]
  def change
    add_column :replies, :original_id, :integer
  end
end
