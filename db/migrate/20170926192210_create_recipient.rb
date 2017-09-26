class CreateRecipient < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_recipients do |t|
      t.references :address
      t.references :line_item
    end

    add_index :spree_recipients , [:address_id , :line_item_id] , :unique => true
  end
end
