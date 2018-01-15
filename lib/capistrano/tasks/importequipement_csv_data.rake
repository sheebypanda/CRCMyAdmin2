namespace :csvimportequipement do

  desc "Importer  en CSV."
  task :import_equipements => :environment do

    require 'csv'

    csv_text = File.read('equipements.csv')
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

  end

end
