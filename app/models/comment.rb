class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :lection
  validates :body, presence: true, allow_blank: false
end
