class Order < ApplicationRecord

  ## Validations ##
  validates :shopify_id, :number, :token, :gateway, :currency, :app_id, :order_number, presence: true

  ## Associations ##
  has_many :line_items
end
