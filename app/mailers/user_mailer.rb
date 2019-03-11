class UserMailer < ApplicationMailer
  default from: Rails.application.secrets.email_from

  def incident_email
    @incident = params[:incident]

    email_nxo = Rails.application.secrets.email_nxo
    email_spie = Rails.application.secrets.email_spie

    email_copy1 = Rails.application.secrets.email_copy1 #AC
    email_copy2 = Rails.application.secrets.email_copy2 #CP
    email_copy3 = Rails.application.secrets.email_copy3 #FJ
    email_copy4 = Rails.application.secrets.email_copy4 #EN

    destination = []

    destination << Rails.application.secrets.email_from
    destination << email_nxo
    destination << email_copy1
    destination << email_copy2
    destination << email_copy3
    destination << email_copy4

    mail(to: destination, subject: "Bordeaux Métropole - Déclaration d'incident sur équipements réseaux" )

  end
end
