class Person < ActiveRecord::Base
  validates :name, presence: true
  # acceptance
  validates :terms_of_service, acceptance: true
end
