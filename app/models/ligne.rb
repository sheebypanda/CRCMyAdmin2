class Ligne < ApplicationRecord
  belongs_to :operateur
  has_many :recettes
  has_many :equipements, through: :recettes
  has_one :localisation, through: :recettes
  validates :numerocompte, presence: true, uniqueness: true

  include PgSearch
  pg_search_scope :ligne_search, :against => {
    :numerocompte => 'A',
    :ndi => 'B',
    :operateur_id => 'C'
  }

end
