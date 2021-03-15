class Publication < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true,
                    length: { minimum: 3 }

  validates :author, length: { minimum: 3 }
end
