class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.string :shopify_id
      t.string :shopify_order_id
      t.string :title
      t.integer :quantity
      t.decimal :price
      t.string :vendor
      t.references :product
      t.references :variant
      t.decimal :total_discount
      t.references :order
      t.timestamps
    end
  end
end
