class Comment < ApplicationRecord
  acts_as_likeable
  has_many :likes
  belongs_to :user, optional: true
  belongs_to :lection, optional: true
  validates :body, presence: true, allow_blank: false

  after_create_commit {
    CommentBroadcastJob.perform_later(self)
  }

end
