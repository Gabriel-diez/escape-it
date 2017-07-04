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

  def success_percentage
    total_steps_success == 0 ? 0 : 100/(total_steps/total_steps_success)
  end

  def total_steps_success
    steps.where(finished: true).count
  end

  def total_steps
    steps.count
  end

<<<<<<< HEAD
  def start
    steps.each do |step|
      step.devices.each { |device| Sensit.new(user).create_notification(device) }
    end
    self.update(started: true)
=======
  def reset
    steps.update_all(finished: false)
    self.update(started: false)
>>>>>>> 1493ee31c94f84e5407fe9914108b533075a9c1a
  end
end
