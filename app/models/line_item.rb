class LineItem < ApplicationRecord

  ## Validations ##
  validates :shopify_id, :title, :quantity, :price, presence: true

  ## Associations ##
  belongs_to :order
  belongs_to :product
  belongs_to :variant


  def self.populate params
    line_items = []
    params.each do |item|
      line_items << LineItem.new(
          shopify_id: item[:id],
          title: item[:title],
          quantity: item[:quantity],
          price: item[:price],
          vendor: item[:vendor],
          product_id: Product.find_by(shopify_id: item["product_id"]).id,
          variant_id: item[:variant_id],
          total_discount: item[:total_discount]
      )
    end
    return line_items
  end

end
