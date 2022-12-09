class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.integer :customer_id, index: true, null: false
      t.string :zip
      t.boolean :invalid_zip, default: false
      t.string :street_name
      t.string :neighborhood
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
