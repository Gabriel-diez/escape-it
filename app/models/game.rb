# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  started    :boolean          default(FALSE)
#  started_at :datetime
#

class Game < ApplicationRecord
  belongs_to :user
  has_many :steps, dependent: :destroy

  validates :name, presence: true

  def self.search(query)
    where("name ILIKE ?", "%#{query}%")
  end

  def success_percentage
    percentage = Float(total_steps_success) / total_steps * 100
    percentage.round(2)
  end

  def total_steps_success
    steps.select { |s| s.is_validated? }.length
  end

  def total_steps
    steps.count
  end

  def start
    steps.each do |step|
      step.devices.each do |device|
        device.update(notification_id: Sensit.new(user).create_notification(device))
      end
    end
    self.update(started: true, started_at: Time.now)
  end

  def reset
    steps.each do |step|
      step.devices.each { |device| Sensit.new(user).delete_notification(device) }
      step.devices.update_all(is_ok: false)
    end
    self.update(started: false)
  end

  def to_s
    self.name
  end

  def next_instruction
    remaining_steps = self.steps.select { |s| !s.is_validated? }
    remaining_steps.length ? remaining_steps[0] : nil
  end
end
