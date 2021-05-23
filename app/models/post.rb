class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :comments, dependent: :destroy
  has_one_attached :picture, dependent: :destroy

  VALID_CATEGORIES = ['Scientific', 'Politics', 'TV Series', 'Anime', 'Films', 'Technologies', 'Music']

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates :category, presence: true, inclusion: {in: VALID_CATEGORIES}
  validates :picture, presence: true
end
