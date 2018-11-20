class User < ApplicationRecord
  acts_as_liker
  has_many :comments, dependent: :destroy
  has_many :lections, dependent: :destroy
  before_create :confirmation_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
end
