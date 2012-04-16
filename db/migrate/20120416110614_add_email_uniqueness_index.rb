class AddEmailUniquenessIndex < ActiveRecord::Migration
  def up
    add_index :hosts, :email, :unique => true
  end

  def down
    remove_index :hosts, :email
  end
end
