class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :shopify_id
      t.datetime  :shopify_created_at
      t.datetime  :shopify_updated_at
      t.integer   :number
      t.string    :token
      t.string    :gateway
      t.decimal   :total_price
      t.decimal   :sub_total_price
      t.decimal   :total_tax
      t.string    :currency
      t.string   :app_id
      t.integer   :order_number
      t.timestamps
    end
  end
end
