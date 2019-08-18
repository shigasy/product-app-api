class Shop < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true, length: { maximum: 200 }

  scope :search_title_description, ->(word) { where('title LIKE :word OR description LIKE :word', word: "%#{word}%") }

end
