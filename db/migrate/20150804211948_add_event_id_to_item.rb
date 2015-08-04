class AddEventIdToItem < ActiveRecord::Migration
  def change
    add_reference :items, :event, index: true, foreign_key: true
  end
end
