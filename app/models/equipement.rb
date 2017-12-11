class Equipement < ApplicationRecord
  has_one :recette, dependent: :destroy
end
