class Equipement < ApplicationRecord
  has_one :recette, dependent: :destroy
  has_one :localisation, through: :recette
  has_one :ligne, through: :recette
  # validates :serial, uniqueness: true

  include PgSearch
  pg_search_scope :equipement_search, :against =>
    {
      :ip => 'A',
      :nom => 'B',
      :asapid => 'C',
      :serial => 'D'
    },
    using: {
      tsearch: {
        prefix: true,
        any_word: true
      }
    }

  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      equipement_hash = row.to_hash
      unless equipement_hash["serial"].to_s.empty?
        equipement = Equipement.where(serial: equipement_hash["serial"])
        if equipement.count == 1
          equipement_hash["datemaintenance"] = Date.parse(equipement_hash["datemaintenance"]) if equipement_hash["datemaintenance"]
          equipement.first.update_attributes(equipement_hash)
        elsif equipement.count == 0
          Equipement.create!(equipement_hash)
        end
      end
    end
  end

end
