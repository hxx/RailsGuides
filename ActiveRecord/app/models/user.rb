class User < ActiveRecord::Base
  validates :login, :email, presence: true
  before_validation :ensure_login_has_a_value

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
end
