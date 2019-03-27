class LineItem < ApplicationRecord

  ## Validations ##
  validates :shopify_id, :title, :quantity, :price, presence: true

  ## Associations ##
  belongs_to :order
  belongs_to :product
  belongs_to :variant


  def self.populate params
    params.each do |item|
      line_item = LineItem.new(
          shopify_id: params[:id],
          title: item[:title],
          quantity: item[:quantity],
          price: item[:price],
          vendor: item[:vendor],
          product_id: Product.find_by(shopify_id: item["product_id"]).id,
          # variant_id: item["id"],
          total_discount: item[:total_discount]
      )
    end
  end

end
