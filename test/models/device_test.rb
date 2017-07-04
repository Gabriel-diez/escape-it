# == Schema Information
#
# Table name: devices
#
#  id              :integer          not null, primary key
#  sensor_id       :integer
#  step_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notification_id :integer
#  device_id       :integer
#  is_ok           :boolean          default(FALSE)
#  value           :string
#

require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
