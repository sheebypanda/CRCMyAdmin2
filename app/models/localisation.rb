class Localisation < ApplicationRecord
  has_many :recettes
  has_many :equipements, through: :recettes
  has_many :lignes, through: :recettes

  validates :nom, presence: true


  geocoded_by :adresse
  after_validation :geocode, :if => lambda{ |obj| obj.adresse_changed? }

  reverse_geocoded_by :lat, :lng, :address => :adresse do |obj,results|
    if geo = results.first
      obj.adresse = geo.street_number+" "+geo.route
      obj.ville = geo.city
      obj.codepostal = geo.postal_code
    end
  end

  after_validation :reverse_geocode, :if => lambda{ |obj| obj.lat_changed? }
end
