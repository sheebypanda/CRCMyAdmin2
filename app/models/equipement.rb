class Equipement < ApplicationRecord
  has_one :recette, dependent: :destroy
  has_one :localisation, through: :recette
  has_one :ligne, through: :recette
  belongs_to :projet, optional: true
  has_and_belongs_to_many :incidents
  validates :serial, uniqueness: true

  include PgSearch
  pg_search_scope :equipement_search, :against =>
    {
      :ip => 'A',
      :nom => 'B',
      :modele => 'C',
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
      if equipement_hash["serial"].present?
        equipement = Equipement.where(serial: equipement_hash["serial"])
        equipement_hash["datemaintenance"] = Date.parse(equipement_hash["datemaintenance"]) if equipement_hash["datemaintenance"]
        equipement_hash = equipement_hash.except!('id_localisation', 'localisation', 'adresse', 'codepostal', 'ville', 'rattachement', 'etage', 'tel', 'mail', 'description', 'lat', 'lng', 'horaires','bp').reject{|k,v| v.blank?}
        if equipement.count == 1
          equipement.first.update_attributes(equipement_hash)
        elsif equipement.count == 0
          Equipement.create!(equipement_hash)
        end
      end

      equipement_hash = row.to_hash
      #Check si localisation existe par son id, sinon par son nom & ville, sinon on la créée
      if equipement_hash["id_localisation"].present?
        begin
          localisation = Localisation.find(equipement_hash["id_localisation"])
        rescue
          localisation = nil
        end
      elsif equipement_hash["localisation"].present?
        localisations = Localisation.where(nom: equipement_hash["localisation"], ville: equipement_hash['ville'])
      end
      equipement_hash = equipement_hash.except!('marque', 'modele', 'nom', 'serial', 'asapid', 'ip', 'iosv', 'sla', 'maintenance', 'coutmaintenance', 'datemaintenance', 'nb_units').reject{|k,v| v.blank?}
      equipement_hash["nom"] = equipement_hash.delete("localisation")
      equipement_hash["id"] = equipement_hash.delete("id_localisation")
      if localisation.present?
        localisation.update_attributes(equipement_hash)
      elsif localisations.present?
        equipement_hash = equipement_hash.except!('id')
        localisations.first.update_attributes(equipement_hash)
      elsif equipement_hash['nom'].present? and equipement_hash['ville'].present? and equipement_hash['adresse'].present?
        Localisation.create!(equipement_hash)
      end

      equipement_hash = row.to_hash
      # Check si une recette lie la localisation à l'equipement. Sinon, on la créée
      if equipement_hash["ip"].present? and (equipement_hash["id_localisation"].present? or (equipement_hash["localisation"].present? and equipement_hash['ville'].present?))
        recette_hash = Hash.new
        recette = Recette.joins(:equipement).where('equipements.serial' => equipement_hash["serial"])
        equipement = Equipement.where(serial: equipement_hash["serial"])
        if equipement_hash['id_localisation'].present?
          begin
            localisation = Localisation.find(equipement_hash['id_localisation'])
            recette_hash['localisation_id'] = localisation.id
          rescue
            localisation = nil
          end
        else
          localisations = Localisation.where(nom: equipement_hash["localisation"], ville: equipement_hash['ville'])
          recette_hash['localisation_id'] = localisations.ids.first
        end
        # equipement_hash = equipement_hash.except!('marque', 'modele', 'nom', 'serial', 'asapid', 'ip', 'iosv', 'sla', 'maintenance', 'coutmaintenance', 'datemaintenance','localisation', 'adresse', 'codepostal', 'ville', 'etage', 'tel', 'mail', 'description', 'lat', 'lng', 'horaires')
        recette_hash['user_id'] = 1
        recette_hash['equipement_id'] = equipement.ids.first
        recette_hash['ligne_id'] = fibreBM.ids.first
        recette_hash['supervision'] = true
        recette_hash['snmp'] = true
        recette_hash['etiquette'] = true
        if recette.count == 1
          recette.first.update_attributes(recette_hash)
        elsif recette.count == 0 and recette_hash['localisation_id'].present? and equipement_hash["serial"].present?
          Recette.create!(recette_hash)
        end
      end
    end
  end

end
