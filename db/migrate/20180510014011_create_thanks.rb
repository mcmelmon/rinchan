class CreateThanks < ActiveRecord::Migration[5.2]
  def change
    create_table :thanks do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :reply, foreign_key: true

      t.timestamps
    end
  end
end
