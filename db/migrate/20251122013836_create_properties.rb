class CreateProperties < ActiveRecord::Migration[8.1]
  def change
    create_table :properties do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.integer :bedrooms
      t.integer :property_type

      t.timestamps
    end
    add_index :properties, :title
    add_index :properties, :description
    add_index :properties, :price
    add_index :properties, :bedrooms
    add_index :properties, :property_type
  end
end
