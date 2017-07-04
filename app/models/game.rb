# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ApplicationRecord
  belongs_to :user
  has_many :steps
end
