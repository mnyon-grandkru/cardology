class Interpretation < ApplicationRecord
  belongs_to :card
  enum :reading => [:birth, :yearly, :planetary]
end
