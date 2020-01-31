class AgendasController < ApplicationController
  before_action :set_agenda, only: %i[show edit update destroy]

  def index
    @agendas = Agenda.all
  end

  def new
    @team = Team.friendly.find(params[:team_id])
    @agenda = Agenda.new
  end

  def create
    @agenda = current_user.agendas.build(title: params[:title])
    @agenda.team = Team.friendly.find(params[:team_id])
    current_user.keep_team_id = @agenda.team.id
    if current_user.save && @agenda.save
      redirect_to dashboard_url, notice: I18n.t('views.messages.create_agenda') 
    else
      render :new
    end
  end

  def destroy
    team_members = @agenda.team.members

    agenda_user = @agenda.user_id
    owner_id = @agenda.team.owner_id
    puts "agend_user:#{agenda_user}"
    puts "owner_id:#{owner_id}"
    puts "current_user:#{current_user}"

    if  agenda_user == current_user.id || owner_id  == current_user.id
      @agenda.destroy
      team_members.each do |members|
        AssignMailer.del_agenda_mail(members.email, @agenda.title).deliver
      end
      redirect_to dashboard_url, notice: I18n.t('views.messages.delete_agenda') 
    elsif 
      redirect_to dashboard_url, notice: I18n.t('views.messages.cannot_delete_only_a_author_owner')   
    else
      redirect_to dashboard_url, notice: I18n.t('views.messages.failed_todelete_agenda') 
    end
  end

  private

  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def agenda_params
    params.fetch(:agenda, {}).permit %i[title description]
  end
end
