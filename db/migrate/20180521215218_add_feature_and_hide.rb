class AddFeatureAndHide < ActiveRecord::Migration[5.2]
  def change
    add_column :replies, :hide, :boolean, default: :false
    add_column :topics, :feature, :boolean, default: :false
    add_column :topics, :hide, :boolean, default: :false
  end
end
