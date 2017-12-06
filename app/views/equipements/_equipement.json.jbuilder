json.extract! equipement, :id, :nom, :marque, :modele, :snmpcontact, :dns, :iosv, :ip, :achat, :garantie, :asapid, :serial, :created_at, :updated_at
json.url equipement_url(equipement, format: :json)
