class Overriding < ActiveRecord::Base
  self.table_name = "PRODUCT"
  self.primary_key = "product_id"

  # using :if and :unless with a symbol
  before_save :normalize_card_number, if: :paid_with_card?

  # using :if and unless with a string
  before_save :normalize_card_number, if: "paid_with_card?"

  # using :if and unless with a proc
  before_save :normalize_card_number,
    if: Proc.new { |order| order.paid_with_card? }

  # multiple conditions for callbacks
  after_create :send_email_to_author, if: :author_wants_eamils?,
    usless: Proc.new { |comment| comment.post.ignore_comments? }
end
