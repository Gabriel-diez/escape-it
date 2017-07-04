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

  def create_notification(device)
    process("#{Sensit::PATHS[:base]}notifications?access_token=#{@user.access_token}", "post", {
      template: "Notification",
      trigger: {
        id_device: device.device_id,
        id_sensor: device.sensor_id,
        type: "GENERIC_PUNCTUAL",
      },
      connector: {
        data: game_step_device_validate_url({ step_id: device.step.id, game_id: device.step.game.id, device_id: device.id }),
        type: "callback",
      },
      mode: 2
    })
  end

  private

  def process(url, method = 'get', body = nil)
    uri = URI(url)
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      request = if method == 'get'
        Net::HTTP::Get.new(uri)
      elsif method == 'post'
        Net::HTTP::Post.new(uri)
      elsif method == 'put'
        Net::HTTP::Put.new(uri)
      end
        
      request.basic_auth @user.client_id, @user.client_secret
      request.body = body unless body.nil?

      JSON.parse(http.request(request).body)
    end
  end

  def save(tokens)
    @user.update!(access_token: tokens['access_token'], refresh_token: tokens['refresh_token'])
  end
end