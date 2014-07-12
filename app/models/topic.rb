class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  scope :public, -> { where(public: true) }
  scope :private, -> { where(public: false) }
  scope :visible_to, -> (user) { user ? all : public }
end
