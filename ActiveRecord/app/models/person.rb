class Person < ActiveRecord::Base
  validates :name, presence: true
  # acceptance
  # validates :terms_of_service, acceptance: true
  validates :terms_of_service, acceptance: { accept: 'yes'}
end
