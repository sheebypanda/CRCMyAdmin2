class Operateur < ApplicationRecord
  has_many :lignes, dependent: :destroy
  validates :nom, presence: true, uniqueness: true
end
