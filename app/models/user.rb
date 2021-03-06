class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tabs
  has_many :ratings
  has_many :comments
  has_many :favorites
  has_many :tabs, through: :favorites
end
