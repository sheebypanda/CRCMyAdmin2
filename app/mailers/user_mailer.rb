class UserMailer < ApplicationMailer
  default from: Rails.application.secrets.email_from

  def incident_email
    @incident = params[:incident]

    email_nxo = Rails.application.secrets.email_nxo
    email_spie = Rails.application.secrets.email_spie

    email_copy1 = Rails.application.secrets.email_copy1
    email_copy2 = Rails.application.secrets.email_copy2
    email_copy3 = Rails.application.secrets.email_copy3
    email_copy4 = Rails.application.secrets.email_copy4
    email_copy5 = Rails.application.secrets.email_copy5


    destination = []

    destination << email_copy1

    mail(to: destination, subject: "Bordeaux Métropole - Déclaration d'incident sur équipements réseaux" )
  end
end
