class Ligne < ApplicationRecord
  belongs_to :operateur
  has_many :recettes, dependent: :destroy
  has_many :equipements, through: :recettes
  has_one :ligne, through: :recettes
  validates :numerocompte, presence: true, uniqueness: true

  include PgSearch
  pg_search_scope :ligne_search, :against => {
    :numerocompte => 'A',
    :ndi => 'B',
    :operateur_id => 'C'
  },
  using: {
    tsearch: {
      prefix: true,
      any_word: true
    }
  }


  def self.import(file)
    require 'csv'
    netgear = Equipement.where(marque: "Netgear").last
    CSV.foreach(file.path, headers: true) do |row|
      ligne_hash = row.to_hash
      # Check si le lien existe, sinon on le créé
      if ligne_hash["numerocompte"].present?
        ligne_hash = ligne_hash.except!('nom site', 'adresse', 'cp', 'ville').reject{|k,v| v.blank?}
        ligne = Ligne.where(numerocompte: ligne_hash["numerocompte"])
        if ligne.count == 1
          ligne.first.update_attributes(ligne_hash)
        elsif ligne.count == 0
          Ligne.create!(ligne_hash)
        end
      end

      ligne_hash = row.to_hash
      # check si la localisation spécifiée dans le tableau existe, sinon la créer
      if ligne_hash['nom site'].present? and ligne_hash['ville'].present? and ligne_hash['adresse'].present?
        ligne_hash = ligne_hash.except!('operateur_id', 'techno', 'numerocompte', 'ndi', 'ippublique', 'identifiantoperateur', 'mdpoperateur', 'debit', 'vlan', 'cout').reject{|k,v| v.blank?}
        ligne_hash['nom'] = ligne_hash.delete("nom site")
        localisations = Localisation.where(nom: ligne_hash['nom'], ville: ligne_hash['ville'])

        if localisations.present?
          localisations.first.update_attributes(ligne_hash)
        else
          Localisation.create!(ligne_hash)
        end

        ligne_hash = row.to_hash
        recette_hash = Hash.new
        recette_hash['user_id'] = 1
        recette_hash['equipement_id'] = netgear.id
        ligne = Ligne.where(numerocompte: ligne_hash['numerocompte'])
        recette_hash['ligne_id'] = ligne.first.id
        localisations = Localisation.where(nom: ligne_hash['nom site'], ville: ligne_hash['ville'])
        recette_hash['localisation_id'] = localisations.first.id
        recette_hash['supervision'] = true
        recette_hash['snmp'] = true
        recette_hash['etiquette'] = true
        recette = Recette.joins(:localisation).where('localisations.nom' => ligne_hash['nom site'], 'localisations.ville' => ligne_hash['ville'])
        if recette.count == 1
          recette.first.update_attributes(recette_hash)
        else
          Recette.create!(recette_hash)
        end
      end
    end
  end

end
