# == Schema Information
#
# Table name: steps
#
#  id         :integer          not null, primary key
#  name       :string
#  finished   :boolean          default(FALSE)
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Step < ApplicationRecord
  belongs_to :game
  has_many :devices

  accepts_nested_attributes_for :devices
end
