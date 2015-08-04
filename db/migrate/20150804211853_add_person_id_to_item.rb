class AddPersonIdToItem < ActiveRecord::Migration
  def change
    add_reference :items, :person, index: true, foreign_key: true
  end
end
