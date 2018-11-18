class Lection < ApplicationRecord
   has_many :comments, dependent: :destroy
   acts_as_taggable_on :tags
   belongs_to :user
   validates :title, uniqueness: { scope: :user_id, message: "must be unique for each of your posts" }
   validates :body,presence: true,length: {maximum: 1500},on: :create,allow_nil: false
end
