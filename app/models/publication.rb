class Publication < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, presence: true,
                    length: { minimum: 3 }

  validates :author, length: { minimum: 3 }
end
