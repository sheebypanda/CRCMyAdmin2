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
    # Choper l'ID de la fibre BM pour la création de recettes
    fibreBM = Ligne.where(numerocompte: 'Fibre privée BM')
    CSV.foreach(file.path, headers: true) do |row|
      equipement_hash = row.to_hash

      #Check si equipement existe par le SN ; Sinon on le créé
      unless equipement_hash["serial"].to_s.empty?
        equipement = Equipement.where(serial: equipement_hash["serial"])
        equipement_hash["datemaintenance"] = Date.parse(equipement_hash["datemaintenance"]) if equipement_hash["datemaintenance"]
        equipement_hash = equipement_hash.except!('localisation', 'adresse', 'codepostal', 'ville', 'etage', 'tel', 'mail', 'description', 'lat', 'lng', 'horaires')
        if equipement.count == 1
          equipement.first.update_attributes(equipement_hash)
        elsif equipement.count == 0
          Equipement.create!(equipement_hash)
        end
      end

      equipement_hash = row.to_hash
      #Check si localisation existe par son nom & ville ; Sinon on la créée
      unless equipement_hash["localisation"].to_s.empty?
        localisation = Localisation.where(nom: equipement_hash["localisation"], ville: equipement_hash['ville'])
        equipement_hash = equipement_hash.except!('marque', 'modele', 'nom', 'serial', 'asapid', 'ip', 'iosv', 'sla', 'maintenance', 'coutmaintenance', 'datemaintenance')
        equipement_hash["nom"] = equipement_hash.delete("localisation")
        if localisation.count == 1
          localisation.first.update_attributes(equipement_hash)
        elsif localisation.count == 0
          Localisation.create!(equipement_hash)
        end
      end

      equipement_hash = row.to_hash
      # Check si une recette lie la localisation à l'equipement. Sinon, on la créée
      unless equipement_hash["serial"].to_s.empty? or equipement_hash["localisation"].to_s.empty?
        recette = Recette.joins(:equipement).where('equipements.serial' => equipement_hash["serial"])
        equipement = Equipement.where(serial: equipement_hash["serial"])
        localisation = Localisation.where(nom: equipement_hash["localisation"], ville: equipement_hash['ville'])
        # equipement_hash = equipement_hash.except!('marque', 'modele', 'nom', 'serial', 'asapid', 'ip', 'iosv', 'sla', 'maintenance', 'coutmaintenance', 'datemaintenance','localisation', 'adresse', 'codepostal', 'ville', 'etage', 'tel', 'mail', 'description', 'lat', 'lng', 'horaires')
        recette_hash = Hash.new
        recette_hash['user_id'] = 1
        recette_hash['equipement_id'] = equipement.ids.first
        recette_hash['localisation_id'] = localisation.ids.first
        recette_hash['ligne_id'] = fibreBM.ids.first
        recette_hash['supervision'] = true
        recette_hash['snmp'] = true
        recette_hash['etiquette'] = true
        if recette.count == 1
          recette.first.update_attributes(recette_hash)
        elsif recette.count == 0
          Recette.create!(recette_hash)
        end
      end
    end
  end

end
