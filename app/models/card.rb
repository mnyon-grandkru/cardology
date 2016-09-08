class Card < ApplicationRecord
  belongs_to :suit
  belongs_to :face
end
