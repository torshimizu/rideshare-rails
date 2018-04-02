class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.date :date
      t.integer :rating
      t.float :cost

      t.timestamps
    end
  end
end
