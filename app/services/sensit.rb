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
    save process("#{Sensit::PATHS[:token]}grant_type=authorization_code&code=#{code}&client_id=#{@user.client_id}&redirect_uri=#{Rails.application.routes.url_helpers.callback_url}", "post")
  end

  def refresh
    save process("#{Sensit::PATHS[:token]}grant_type=refresh_token&client_id=#{@user.client_id}&refresh_token=#{@user.refresh_token}", 'post')
  end

  def devices
    process("#{Sensit::PATHS[:base]}devices?access_token=#{@user.access_token}")['data']
  end

  def sensors(device_id)
    process("#{Sensit::PATHS[:base]}devices/#{device_id}/?access_token=#{@user.access_token}")['data']['sensors']
  end

  def delete_notification(device)
    process("#{Sensit::PATHS[:base]}notifications/#{device.notification_id}?access_token=#{@user.access_token}", "delete")
  end

  def create_notification(device)
    notification_type = "GENERIC_PUNCTUAL"
    if device.sensor_type == 'light' || device.sensor_type == 'temperature_humidity'
      notification_type = "GENERIC_REGULAR"
    end

    return process("#{Sensit::PATHS[:base]}notifications?access_token=#{@user.access_token}", "put", {
      template: "Notification",
      trigger: {
        id_device: device.device_id,
        id_sensor: device.sensor_id,
        value: device.value,
        type: notification_type,
      },
      connector: {
        data: Rails.application.routes.url_helpers.game_step_device_validate_url(step_id: device.step.id, game_id: device.step.game.id, device_id: device.id),
        type: "callback",
      },
      mode: -1
    })['data']['id']
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
      elsif method == 'delete'
        Net::HTTP::Delete.new(uri)
      end

      request['Content-type'] = 'application/json'
        
      request.basic_auth @user.client_id, @user.client_secret
      request.body = body.to_json unless body.nil?

      response = http.request(request).body
      Rails.logger.error response

      response && response.length > 2 ? JSON.parse(response) : nil
    end
  end

  def save(tokens)
    @user.update!(access_token: tokens['access_token'], refresh_token: tokens['refresh_token'])
  end
end