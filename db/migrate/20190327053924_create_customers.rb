class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string     :shopify_id
      t.string      :email
      t.string      :first_name
      t.string      :last_name
      t.boolean     :accepts_marketing
      t.timestamps
    end
  end
end
