class Person < ActiveRecord::Base
  validates :name, presence: true
  # acceptance
  # validates :terms_of_service, acceptance: true
  validates :terms_of_service, acceptance: { accept: 'yes'}

  # validates_associated
  has_many :books
  validates_associated :books

  # confirmation
  validates :email, confirmation: true
  validates :email_confirmation, presence: true

  # exclusion
  validates :subdomain, exclusion: { in: %w(www us ca jp),
    message: "%{value} is reserved."}

  # inclusion
  validates :size, inclusion: { in: %w(small medium large),
    message: "%{value} is not a valid size"}

  # format
  validates :legacy_code, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters"}
end
