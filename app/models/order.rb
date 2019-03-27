class Order < ApplicationRecord

  ## Validations ##
  validates :shopify_id, :number,  :currency, :order_number, presence: true

  ## Associations ##
  has_many :line_items
  accepts_nested_attributes_for :line_items


  def self.chart_data
    all.collect{|order| [order.shopify_created_at, (order.total_price - order.total_price/5 - order.total_price * 2 / 5).to_f ] }
  end

end
