class Product < ActiveRecord::Base
  # set table_name
  self.table_name = "PRODUCT"
  # set primary_key
  self.primary_key = "product_id"
end
