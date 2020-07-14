class Education < ApplicationRecord
  DESCRIPTION_MAX_LENGTH = 1000
  belongs_to :cv
  validates :school, presence: true
  validates :description, length: { maximum: DESCRIPTION_MAX_LENGTH }

  scope :chronological_order, -> { order('ended_on IS NULL DESC, ended_on DESC, started_on DESC') }
end
