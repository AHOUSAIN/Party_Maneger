class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :name
      t.string :date
      t.string :location
      t.string :start_time
      t.string :end_time
      t.string :description
      t.string :rsvp_date
      t.integer :host_id

      t.timestamps
    end
    add_index :parties, :host_id
  end
end
