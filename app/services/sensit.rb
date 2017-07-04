require 'net/http'
require 'base64'
require 'json'

class Sensit

  PATHS = {
    token: "https://#{Rails.configuration.sensit_api_url}/oauth/token?"
  }

  def initialize(user)
    @user = user
  end

  def authenticate(code)
    save post("#{Sensit::PATHS[:token]}grant_type=authorization_code&code=#{code}&client_id=#{@user.client_id}&redirect_uri=http://localhost:3000/callback")
  end

  def refresh
    save post("#{Sensit::PATHS[:token]}grant_type=refresh_token&client_id=#{@user.client_id}&refresh_token=#{@user.refresh_token}")
  end

  private

  def post(url)
    uri = URI(url)
    Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Post.new uri
      request.basic_auth @user.client_id, @user.client_secret
      response = http.request request
      JSON.parse(response.body)
    end
  end

  def save(tokens)
    puts tokens
    @user.update!(access_token: tokens[:access_token], refresh_token: tokens[:refresh_token])
  end
end