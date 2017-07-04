class Step < ApplicationRecord
  belongs_to :game
  has_many :devices
end
