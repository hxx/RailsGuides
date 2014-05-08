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

  # length
  validates :name, length: { minimum: 2 }
  validates :bio, length: { maximum: 500 }
  validates :password, length: { in: 6..20 }
  validates :registration_number, length: { is: 6 }

  validates :bio, length: { maximum: 1000,
    too_long: "%{count} characters is the maximum allowed" }

  validates :content, length: {
    minimum: 300,
    maximum: 400,
    tokenizer: lambda { |str| str.scan(/\w+/) },
    too_short: "must have at least %{count} words"
    too_long: "must have at most %{count} words"
  }

  # numericality
  validates :points, numericality: true
  validates :games_played, numericality: { only_integer: true }

  # presence
  validates :name, :login, :email, presence: true

  # absence
  validates :name, :login, :email, absence: true

  # uniqueness
  validates :email, uniqueness: true
  validates :name, uniqueness: { case_sensitive: false }
end
