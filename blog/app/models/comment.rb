class Comment < ActiveRecord::Base
  belongs_to :article

  def self.find_no_spam
    where("is_spam = ?", false).order("created_at DESC")
  end
end
