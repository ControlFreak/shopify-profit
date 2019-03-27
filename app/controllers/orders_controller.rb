class OrdersController < ApplicationController

  def index
    @orders = Order.all
    @chart_data = Order.chart_data
  end

  def order_creation_webhook
    puts "###########################################"
    puts params
    puts "###########################################"

  end


end
