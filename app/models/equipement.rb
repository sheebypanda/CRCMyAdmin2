class Equipement < ApplicationRecord
  has_one :recette, dependent: :destroy
  has_one :localisation, through: :recette
  has_one :ligne, through: :recette
  # validates :serial, presence: true

  include PgSearch
  pg_search_scope :equipement_search, :against =>
    {
      :ip => 'A',
      :nom => 'B',
      :asapid => 'C',
      :modele => 'D'
    },
    using: {
      tsearch: {
        prefix: true,
        any_word: true
      }
    }


end
