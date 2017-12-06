class Recette < ApplicationRecord
  belongs_to :user
  belongs_to :equipement
  belongs_to :ligne
  belongs_to :localisation
end
