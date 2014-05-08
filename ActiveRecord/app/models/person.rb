class Person < ActiveRecord::Base
  validates :name, presence: true
  # acceptance
  # validates :terms_of_service, acceptance: true
  validates :terms_of_service, acceptance: { accept: 'yes'}

  # validates_associated
  has_many :books
  validates_associated :books
end
