class Search < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  scope :ordered, -> { order(views: :desc) }
  scope :localized, -> { where(locale: I18n.locale.to_s) }

  before_validation :sanitize_query
  validates :query, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  def results
    Cv.published.full_text_search(query)
  end

  def seo_title
    query.titleize
  end

  def slug_candidates
    [:query, %i[query locale]]
  end

  def self.sanitized_query(query)
    query.downcase.squish.strip
  end

  private

  def sanitize_query
    self.query = query.downcase.squish.strip
  end
end
