class Location < ApplicationRecord
  belongs_to :user

  validates :original_address, presence: true
  # validates :radius, numericality: { greater_than_or_equal_to: 0 }

  after_validation :geocode, if: ->(obj) { obj.original_address.present? && obj.original_address_changed? }

  scope :chronological_order, -> { order(created_at: :desc) }

  geocoded_by :original_address do |location, results|
    result = results.first
    if result
      location.latitude = result.latitude
      location.longitude = result.longitude
      location.city = result.city
      location.country = result.country
      location.geocoded_address = result.address
      location.province_code = result.state_code
      location.region = result.state
    end
  end

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
end
