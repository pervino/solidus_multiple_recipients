class AddOptionalAddressToShipment < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_shipments, :optional_address, :integer
  end
end
