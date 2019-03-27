# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rest-client'

def populate_orders
  response = RestClient.get "#{ShopifyBaseUrl}orders.json"
  orders = JSON.parse(response.body)["orders"]
  orders.each do |order|
    ord = Order.new(
        shopify_id: order["id"],
        shopify_created_at: order["created_at"],
        shopify_updated_at: order["updated_at"],
        number: order["number"],
        token: order["token"],
        gateway: order["gateway"],
        total_price: order["total_price"],
        sub_total_price: order["sub_total_price"],
        total_tax: order["total_tax"],
        currency: order["currency"],
        app_id: order["app_id"],
        order_number: order["order_number"]
    )
    if ord.save
      puts "Order saved with id #{ord.shopify_id}"
      populate_product(order)
      populate_line_items(order)
    else
      puts ord.errors
    end
  end
end

def populate_line_items order
  order["line_items"].each do |item|
    line_item = LineItem.new(
        shopify_id: item["id"],
        shopify_order_id: order["id"],
        title: item["title"],
        quantity: item["quantity"],
        price: item["price"],
        vendor: item["vendor"],
        product_id: Product.find_by(shopify_id: item["product_id"]).id,
        # variant_id: item["id"],
        total_discount: item["total_discount"]
    )
    if line_item.save
      puts "Line Item saved with id #{line_item.shopify_id}"
    else
      puts line_item.errors
    end
  end
end

def populate_product order
  order["line_items"].each do |item|
    product = Product.new(shopify_id: item["product_id"], name: item["name"])
    if product.save
      puts "Product saved with id #{product.shopify_id}"
    else
      puts ord.errors
    end
  end
end

def populate_customers
  response = RestClient.get "#{ShopifyBaseUrl}customers.json"
  customers = JSON.parse(response.body)["customers"]
  customers.each do |customer|
    cust = Customer.new(
        shopify_id: customer["id"],
        email: customer["email"],
        first_name: customer["first_name"],
        last_name: customer["last_name"],
        accepts_marketing: customer["accepts_marketing"]
    )
    if cust.save
      puts "Customer saved with id #{cust.shopify_id}"
    else
      puts cust.orders
    end
  end
end


populate_customers
populate_orders