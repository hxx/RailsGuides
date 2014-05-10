class User < ActiveRecord::Base
  validates :login, :email, presence: true
  before_validation :ensure_login_has_a_value

  # register callbacks on certain life cycle events
  before_validation :normalize_name, on: :before_create

  # :on takes an array as well
  after_validation :set_location, on: [ :create, :update ]

  # macro-style class methods
  before_create do
    self.name = login.capitalize if name.blank?
  end

  # ordinary method for implementing a callback
  protected
    def ensure_login_has_a_value
      if login.nil?
        self.login = email unless email.blank
      end
    end

    def normalize_name
      self.name = self.name.downcase.titleize
    end

    def set_location
      self.location = LocationService.query(self)
    end
end
