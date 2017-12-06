namespace :csvimportelignes do

  desc "Importer  en CSV."
  task :import_lignes => :environment do

    require 'csv'

    csv_text = File.read('lignes.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|

      ll = Localisation.create!({
        :nom => row[1],
        :adresse => row[2],
        :tel => row[3],
        :mail => row[6],
        }
      )

      vv = Ligne.create!({
        :numerocompte => row[0],
        :ndi => row[3],
        # :debit => row[0],
        :ippublique => row[5],
        :mail => row[6],
        :tel => row[3],
        :identifiantoperateur => row[7],
        :mdpoperateur => row[8],
        :compte => row[9],
        :motdepasse => row[10],
        :operateur_id => 1,
        }
      )

    end

  end

end
