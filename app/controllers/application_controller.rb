class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :link_to_api

  def link_to_api
    return if params[:code] || !current_user || current_user.client_id.nil? || !current_user.access_token.nil?
    redirect_to "http://www.sensit.io/oauth/authorize?client_id=#{current_user.client_id}&response_type=code&redirect_uri=#{callback_url}"
  end
end
