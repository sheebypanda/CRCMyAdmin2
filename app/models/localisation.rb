class Localisation < ApplicationRecord
  has_many :recettes, dependent: :destroy
  has_many :localisations, through: :recettes
  has_many :lignes, through: :recettes
  validates :nom, presence: true

  include PgSearch
  pg_search_scope :localisation_search, :against => {
    :nom => 'A',
    :adresse => 'B',
    :ville => 'C',
    :description => 'D'
  },
  using: {
    tsearch: {
      prefix: true,
      any_word: true
    }
  }

  # after_validation :geocode, :if => lambda{ |obj| obj.adresse_changed? }
  after_validation :geocode
  def full_address
    adresse + ', ' + ville + ', FR'
  end
  after_validation :geocode
  geocoded_by :full_address, :latitude  => :lat, :longitude => :lng

  # reverse_geocoded_by :lat, :lng, :address => :adresse do |obj,results|
  #   if geo = results.first
  #     obj.adresse = geo.street_number+" "+geo.route
  #     obj.ville = geo.city
  #     obj.codepostal = geo.postal_code
  #   end
  # end

  # after_validation :reverse_geocode, :if => lambda{ |obj| obj.lat_changed? }

  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      localisation_hash = row.to_hash
      unless localisation_hash["nom"].to_s.empty?
        localisation = Localisation.where(nom: localisation_hash["nom"], ville: localisation_hash['ville'])
        if localisation.count == 1
          localisation.first.update_attributes(localisation_hash)
        elsif localisation.count == 0
          Localisation.create!(localisation_hash)
        end
      end
    end
  end

end
