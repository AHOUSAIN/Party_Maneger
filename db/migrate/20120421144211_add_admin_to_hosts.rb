class AddAdminToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :admin, :boolean , :default => false

  end
end
