class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :name
      t.date :date
      t.string :location
      t.time :start_time
      t.time :end_time
      t.string :description
      t.date :rsvp_date
      t.integer :host_id

      t.timestamps
    end
    add_index :parties, :host_id
  end
end
