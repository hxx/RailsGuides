class User < ActiveRecord::Base
  validates :login, :email, presence: true

  before_validation :ensure_login_as_a_value

  protected
  def ensure_login_as_a_value
    if login.nil?
      self.login = email unless email.blank?
    end
  end
end

class User < ActiveRecord::Base
  validates :login, :email, presence: true

  before_create do
    self.name = login.capitalize if name.blank?
  end
end


class User < ActiveRecord::Base
  before_validation :normalize_name, on: :before_create

  # :on takes an array as well
  after_validation :set_location, on: [ :create, :update ]

  protected
  def normalize_name
    self.name = self.name.downcase.titleize    
  end

  def set_location
    self.location = LocationService.query(self)
  end
end

# Using :if and :unless with a Symbol
class Order < ActiveRecord::Base
  before_save :normalize_card_number, if: :paid_with_card?
end

# Using :if and :unless with a String
class Order < ActiveRecord::Base
  before_save :normalize_card_number, if: "paid_with_card?"
end

# Using :if and :unless with a Proc
class Order < ActiveRecord::Base
  before_save :normalize_card_number,
    if: Proc.new { |order| order.paid_with_card? }
end
