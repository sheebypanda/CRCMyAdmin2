class Recette < ApplicationRecord
  belongs_to :user
  belongs_to :equipement
  belongs_to :ligne
  belongs_to :localisation

  include PgSearch
  multisearchable :against => [
    :equipement_ip,
    :equipement_serial,
    :equipement_modele,
    :equipement_nom,
    :equipement_asapid,
    :equipement_marque,
    :ligne_ndi,
    :ligne_numerocompte,
    :localisation_nom,
    :localisation_ville,
    :localisation_adresse]

  PgSearch.multisearch_options = {
    :using => { :tsearch => { :prefix => true } },
    :ignoring => :accents
  }

  def equipement_ip
    equipement.ip
  end
  def equipement_nom
    equipement.nom
  end
  def equipement_asapid
    equipement.asapid
  end
  def equipement_marque
    equipement.marque
  end
  def equipement_modele
    equipement.modele
  end
  def equipement_serial
    equipement.serial
  end
  def ligne_ndi
    ligne.ndi
  end
  def ligne_numerocompte
    ligne.numerocompte
  end
  def localisation_nom
    localisation.nom
  end
  def localisation_ville
    localisation.ville
  end
  def localisation_adresse
    localisation.adresse
  end


end
