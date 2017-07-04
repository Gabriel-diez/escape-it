class DevicesController < ApplicationController
  before_action :set_device, only: [:validate]

  def validate
    Device.find(params[:device_id]).update(valid: true)
  end
end
