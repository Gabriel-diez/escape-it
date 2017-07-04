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
#

class Game < ApplicationRecord
  belongs_to :user
  has_many :steps

  def self.search(query)
    where("name ILIKE ?", "%#{query}%")
  end

  def success_percentage
    total_steps_success == 0 ? 0 : 100/(total_steps/total_steps_success)
  end

  def total_steps_success
    steps.where(finished: true).count
  end

  def total_steps
    steps.count
  end

  def start
    steps.each do |step|
      step.devices.each { |device| Sensit.new(user).create_notification(device) }
    end
    self.update(started: true)
  end

  def reset
    steps.update_all(finished: false)
    self.update(started: false)
  end
end
