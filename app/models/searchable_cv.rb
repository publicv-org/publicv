class SearchableCv < ApplicationRecord
  include PgSearch::Model

  self.primary_key = :cv_id

  belongs_to :cv
  belongs_to :user

  pg_search_scope(
    :search_any_en,
    against: :search_en_content_tsvector,
    using: {
      tsearch: {
        dictionary: 'cv_en',
        tsvector_column: 'search_en_content_tsvector',
        any_word: true
      }
    },
    ranked_by: ':tsearch'
  )

  pg_search_scope(
    :search_any_it,
    against: :search_it_content_tsvector,
    using: {
      tsearch: {
        dictionary: 'cv_it',
        tsvector_column: 'search_it_content_tsvector',
        any_word: true
      }
    },
    ranked_by: ':tsearch'
  )

  def formatted_map_results
    {
      name: abbr_name,
      location: {
        lng: longitude,
        lat: latitude
      },
      subdomain: subdomain
    }
  end

  def abbr_name
    "#{first_name} #{last_name[0]}."
  end

  def self.search(locale, query)
    if locale == 'en'
      SearchableCv.search_any_en(query).includes(:cv, :user)
    else
      SearchableCv.search_any_it(query).includes(:cv, :user)
    end
  end

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end
end
