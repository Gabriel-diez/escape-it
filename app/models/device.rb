# == Schema Information
#
# Table name: devices
#
#  id              :integer          not null, primary key
#  sensor_id       :integer
#  valid           :boolean
#  step_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notification_id :integer
#  device_id       :integer
#

class Device < ApplicationRecord
  belongs_to :step
  validates :value, :sensor_id, :device_id
end
