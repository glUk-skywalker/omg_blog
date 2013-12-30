class Article < ActiveRecord::Base
  validates :owner_id, presence: true
  validates :title, presence: true
  validates :text, presence: true, length: { minimum: 30 }

  belongs_to :user
end
