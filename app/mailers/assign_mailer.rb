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

  def del_agenda_mail(email, title)
    @email = email
    @title = title
    mail to: @email, subject: I18n.t('view.messages.delete_agenda')
  end

  def owner_change_mail(email,team_name)
    @email = email
    @team_name = team_name
    mail to: @email, subject: 'チームのリーダに就任しました！'
  end

end

