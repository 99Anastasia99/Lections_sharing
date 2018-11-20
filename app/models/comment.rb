class Comment < ApplicationRecord
  acts_as_likeable
  has_many :likes
  belongs_to :user
  belongs_to :lection
  validates :body, presence: true, allow_blank: false

  after_create_commit {
    CommentBroadcastJob.perform_later(self)
  }

end
