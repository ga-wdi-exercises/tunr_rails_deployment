class Artist < ActiveRecord::Base
  has_many :songs, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
