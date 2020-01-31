class AssignMailer < ApplicationMailer
  default from: 'from@example.com'

  def assign_mail(email, password)
    @email = email
    @password = password
    mail to: @email, subject: I18n.t('views.messages.complete_registration')
  end

  def update_mail(email, name)
    @email = email
    @neme = name
    mail to: @email, subject: I18n.t('views.messages.ownership_transferred')
  end

end
