class OrdersController < ApplicationController

  def index
    @orders = Order.all
    @chart_data = Order.chart_data
  end

  def order_creation_webhook
    puts "###########################################"
    puts params
    puts "###########################################"
    order = Order.new(
        shopify_id: params[:order][:id],
        shopify_created_at: params[:order][:created_at],
        shopify_updated_at: params[:order][:updated_at],
        number: params[:order][:number],
        token: params[:order][:token],
        gateway: params[:order][:gateway],
        total_price: params[:order][:total_price],
        sub_total_price: params[:order][:sub_total_price],
        total_tax: params[:order][:total_tax],
        currency: params[:order][:currency],
        app_id: params[:order][:app_id],
        order_number: params[:order][:order_number]
    )

    order.line_items = LineItem.populate(params[:line_items])
    if order.save
      puts "Order Saved"
    else
      puts order.errors.inspect
    end
  end


end
