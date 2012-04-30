class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.string :email
      t.integer :invite_code
      t.integer :expected_attendence
      t.integer :actual_attendence
      t.integer :party_id

      t.timestamps
    end
    add_index :guests, :party_id
  end
end
