class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  validates :title, presence: true
end
