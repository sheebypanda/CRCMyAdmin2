namespace :csvimportelignes do

  desc "Importer les lignes et les localisations."
  task :import_lignes => :environment do

    require 'csv'

    csv_text = File.read('lignes.csv')
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
      }
    )
    end

  end

end
