class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.text :item
      t.boolean :confirmed
      t.references :user, index: true, foreign_key: true, null: false
      t.references :event, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
