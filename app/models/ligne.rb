class Ligne < ApplicationRecord
  belongs_to :operateur
  has_many :recettes
end
