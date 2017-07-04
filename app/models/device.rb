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
#  sensor_type     :string
#

class Device < ApplicationRecord
  belongs_to :step
  validates :sensor_id, :device_id, presence: true
  after_create do
    self.update(notification_id: Sensit.new(step.game.user).create_notification(self)) if step.game.started
  end
end
