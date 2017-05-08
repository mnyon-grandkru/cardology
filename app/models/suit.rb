class Suit < ApplicationRecord
  scope :actual, lambda { where.not :name => 'No Suit' }
end
