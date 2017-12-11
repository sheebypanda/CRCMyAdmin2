class Operateur < ApplicationRecord
  has_many :lignes, dependent: :destroy
end
