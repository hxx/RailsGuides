class Overriding < ActiveRecord::Base
  self.table_name = "PRODUCT"
  self.primary_key = "product_id"
end
