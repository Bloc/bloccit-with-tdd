class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, length: { minimum: 5 }
  validates :body, presence: true
  validates :user_id, presence: true

  after_create :send_favorite_emails

  default_scope { order('updated_at DESC') }

  private

  def send_favorite_emails
    post.favorites.each do |favorite|
      if should_receive_update_for?(favorite)
        FavoriteMailer.new_comment(favorite.user, post, self).deliver
      end
    end
  end

  def should_receive_update_for?(favorite)
    user_id != favorite.user_id && favorite.user.email_favorites?
  end
end
