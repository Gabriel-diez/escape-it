class SensitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sensit

  def callback
    @api.authenticate(params[:code])
    redirect_to edit_user_registration_url, notice: 'Ok'
  end

  def refresh
    @api.refresh
    redirect_to edit_user_registration_url, notice: 'Ok'
  end

  private

  def set_sensit
    @api = Sensit.new(current_user)
  end
end