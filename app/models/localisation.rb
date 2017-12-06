class Localisation < ApplicationRecord
  has_many :recettes
  has_many :equipements, through: :recettes
  has_many :lignes, through: :recettes
end
