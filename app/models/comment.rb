class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, length: { minimum: 5 }
  validates :body, presence: true
  validates :user_id, presence: true
end
