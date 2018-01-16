# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'
# exec("pwd")
csv_text = File.read('lib/seeds/lignes.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|

  vv = Ligne.create!({
    :operateur_id => 1,
    :techno => row[4],
    :ndi => row[10],
    :numerocompte => row[11],
    :ippublique => row[12],
    :vlan => row[13],
    :debit => row[14],
    :cout => row[18]
    #:mail => row[6],
    #:tel => row[3],
    #:identifiantoperateur => row[11],
    #:mdpoperateur => row[8],
    #:compte => row[9],
    #:motdepasse => row[10]
    }
  )

  ll = Localisation.create!({
    :ville => row [0],
    :nom => row[1],
    :adresse => row[2],
    :description => row[3]
  })

end

csv_text = File.read('lib/seeds/equipements.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|

  Equipement.create!({
      :nom => row[0],
      :snmpcontact => row[1],
      :dns => row[2],
      :iosv => row[3],
      :ip => row[4],
      :modele => row[5],
      :marque => row[6],
    }
  )
end
