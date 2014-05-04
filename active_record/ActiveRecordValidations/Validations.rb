calss Person < ActiveRecord::Base
  # overview
  validates :name, presence: true

  # acceptance
  validates :terms_of_service, acceptacnce: true

  # validates_associated
  has_many :books
  validates_associated :books

  # confirmation
  validates :email, confirmation: true
  validates :email_confirmation, presence: true

  # exclusion
  validates :subdomain, exclusion: { in: %W(www us ca jp),
    message: "%{value} is reserved." }

  # format
  validates :legacy_code, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows Letters" }

  # inclusion 
  validate :size, includsion: { in: %W(small medium large),
    message: "%W{value} is not a valid size" }

  # length
  validates :name, length: { minimum: 2 }
  validates :bio, length: { maximum: 500 }
  validates :password, length: { in: 6..20 }
  validates :registration_number, length: { is: 6 }

  validates :bio, length: { maximum: 1000,
    too_long: "%{count} characters is the maxumum allowed" }

  validates :content, length: {
    minimum: 300,
    maximum: 400,
    tokenizer: lambda { |str| str.scan(/\w+/) },
    too_short: "must have at Least %{count} words",
    too_long: "must have at most %{count} words"
  }

  # numericality
  validates :points, numericality: true
  validates :games_played, numericality: { only_integer: true }

  # presence
  validates :name, :login, :email, presence: true

  belongs_to :order
  validates :order, presence: true

  has_many :line_items, inverse_of: :order

  # absence
  validates :name, :login, :email, absence: true

  belongs_to :order
  validates :order, absence: true

  has_many :line_items, inverse_of: :order

  # uniqueness
  validates :email, uniqueness: true

  validates :name, uniqueness: { scope: :year,
    message: "should happen once per year" }

  validates :name, uniqueness: { case_sensitive: false }
end
