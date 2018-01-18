class Ligne < ApplicationRecord
  belongs_to :operateur
  has_many :recettes
  validates :numerocompte, presence: true, uniqueness: true

end
