class Comment < ApplicationRecord
  validates :body, presence: true
  validates :user, presence: true
  validates :product, presence: true
  validates :rating, numericality: { only_integer: true }, :inclusion => 1..5
  after_create_commit { CommentUpdateJob.perform_later(self, @user) }
  belongs_to :user
  belongs_to :product

  default_scope { order(created_at: :desc) }
  
  scope :rating_desc, -> { order(rating: :desc) }
  
end

