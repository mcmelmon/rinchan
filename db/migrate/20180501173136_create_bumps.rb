class CreateBumps < ActiveRecord::Migration[5.2]
  def change
    create_table :bumps do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :topic, foreign_key: true

      t.timestamps
    end
  end
end
