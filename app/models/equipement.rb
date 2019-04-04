class Equipement < ApplicationRecord
  has_one :recette, dependent: :destroy
  has_one :localisation, through: :recette
  has_one :ligne, through: :recette
  belongs_to :projet, optional: true
  belongs_to :livraison, optional: true
  has_and_belongs_to_many :incidents
  validates :serial, uniqueness: true

  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      equipement_hash = row.to_hash
      if equipement_hash["reference_livraison"].present?
        equipement_hash["livraison_id"] = Livraison.where(nom: equipement_hash["reference_livraison"]).first.id.to_s
      end
      if equipement_hash["marque"].present? and equipement_hash["modele"].present? and equipement_hash["serial"].present?
        equipement_hash.each_value(&:strip!)
        equipement_hash = equipement_hash.except!('reference_livraison').reject{|k,v| v.blank?}
        Equipement.create!(equipement_hash)
      end
    end
  end

end
