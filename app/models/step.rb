# == Schema Information
#
# Table name: steps
#
#  id         :integer          not null, primary key
#  name       :string
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Step < ApplicationRecord
  belongs_to :game
  has_many :devices, dependent: :delete_all

  validates :name, presence: true
  accepts_nested_attributes_for :devices

  def is_validated?
    return false if devices.empty?
    devices.where(is_ok: false).empty?
  end
end
