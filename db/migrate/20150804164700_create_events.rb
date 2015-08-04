class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.string :date
      t.string :time
      t.string :location
      t.string :address_line1
      t.string :city
      t.string :state
      t.string :zip
      t.timestamps null: false
    end
  end
end
