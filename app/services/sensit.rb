require 'net/http'
require 'base64'
require 'json'

class Sensit

  PATHS = {
    token: "https://#{Rails.configuration.sensit_api_url}/oauth/token?",
    base: "https://#{Rails.configuration.sensit_api_url}/v2/",
  }

  def initialize(user)
    @user = user
  end

  def authenticate(code)
    save process("#{Sensit::PATHS[:token]}grant_type=authorization_code&code=#{code}&client_id=#{@user.client_id}&redirect_uri=http://localhost:3000/callback")
  end

  def refresh
    save process("#{Sensit::PATHS[:token]}grant_type=refresh_token&client_id=#{@user.client_id}&refresh_token=#{@user.refresh_token}", 'post')
  end

  def devices
    process("#{Sensit::PATHS[:base]}devices?access_token=#{@user.access_token}")['data']
  end

  private

  def process(url, method = 'get')
    uri = URI(url)
    Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
      request = method == 'get' ? Net::HTTP::Get.new(uri) : Net::HTTP::Post.new(uri)
      request.basic_auth @user.client_id, @user.client_secret
      JSON.parse(http.request(request).body)
    end
  end

  def save(tokens)
    @user.update!(access_token: tokens['access_token'], refresh_token: tokens['refresh_token'])
  end
end