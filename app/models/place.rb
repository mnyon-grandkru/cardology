class Place < ApplicationRecord
  belongs_to :card
  belongs_to :spread
end
