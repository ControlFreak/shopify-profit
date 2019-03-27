class LineItem < ApplicationRecord

  ## Validations ##
  validates :shopify_id, :title, :quantity, :price, presence: true

  ## Associations ##
  belongs_to :order
  belongs_to :product
  belongs_to :variant


end
