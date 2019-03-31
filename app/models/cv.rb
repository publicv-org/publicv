class Cv < ApplicationRecord
  include PgSearch

  ABOUT_MAX_LENGTH = 120
  CV_SECTIONS = %w[intro skills extras].freeze

  belongs_to :user
  has_many :educations, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :languages, dependent: :destroy
  has_many :locations, through: :user

  validates :about, length: { maximum: ABOUT_MAX_LENGTH }
  validates :user, uniqueness: true

  accepts_nested_attributes_for :user

  has_attached_file :headshot,
                    styles: { default: '185x185#', large: '370x370#' },
                    default_url: '/images/:style/missing_headshot.png'
  validates_attachment :headshot, size: { in: 40..4000.kilobytes },
                                  content_type: { content_type: ['image/jpeg', 'image/png'] }

  # TODO: Replace hard coded dictionary with locale
  pg_search_scope :full_text_search,
                  against: {
                    about: :B,
                    skills: :B,
                    working_skills: :A
                  },
                  associated_against: {
                    educations: [
                      %i[degree A],
                      %i[description C],
                      %i[school B]
                    ],
                    experiences: [
                      %i[company B],
                      %i[description C],
                      %i[title A]
                    ],
                    languages: [
                      %i[language A],
                      %i[level B]
                    ],
                    locations: [
                      %i[city A],
                      %i[country B],
                      %i[geocoded_address A],
                      %i[original_address B]
                    ],
                    user: [
                      %i[first_name A],
                      %i[last_name A]
                    ]
                  },
                  using: { tsearch: { prefix: true, dictionary: 'english' } }

  def abbr_name
    "#{user.first_name} #{user.last_name[0]}."
  end
end