json.extract! livraison, :id, :user_id, :nom, :commande, :commentaire, :created_at, :updated_at
json.url livraison_url(livraison, format: :json)
