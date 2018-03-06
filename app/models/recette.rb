class Recette < ApplicationRecord
  belongs_to :user
  belongs_to :equipement
  belongs_to :ligne
  belongs_to :localisation

  include PgSearch
  pg_search_scope :recette_search,
    associated_against: {
      equipement: [:nom, :ip, :asapid,],
      localisation: [:ville, :adresse, :nom],
      ligne: [:techno]
    }

end
