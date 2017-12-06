json.extract! recette, :id, :user_id, :equipement_id, :ligne_id, :localisation_id, :snmp, :tacacs, :testdebit, :supervision, :etiquette, :created_at, :updated_at
json.url recette_url(recette, format: :json)
