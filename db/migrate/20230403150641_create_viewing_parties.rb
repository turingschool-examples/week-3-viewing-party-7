class CreateViewingParties < ActiveRecord::Migration[7.0]
  def change
    create_table :viewing_parties do |t|
      t.string :duration
      t.string :time
      t.string :date

      t.timestamps
    end
  end
end
