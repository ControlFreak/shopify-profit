class Product < ApplicationRecord

  ## Validations ##
  validates :shopify_id, :name, presence: true
end
