json.extract! localisation, :id, :nom, :adresse, :codepostal, :ville, :etage, :tel, :mail, :description, :lat, :lng, :created_at, :updated_at
json.url localisation_url(localisation, format: :json)
