# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  sensor_id  :integer
#  valid      :boolean
#  step_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
