class Lection < ApplicationRecord
   acts_as_taggable_on :tags
   belongs_to :user
   validates :title, uniqueness: { scope: :user_id, message: "must be unique for each of your posts" }
end
