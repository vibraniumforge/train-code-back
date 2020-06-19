class CreateTrains < ActiveRecord::Migration[6.0]
  def change
    create_table :trains do |t|
      t.string :symbol
      t.string :origin
      t.string :destination
      t.string :frequency
      t.string :notes
      t.string :description
      t.string :railroad

      t.timestamps
    end
  end
end
