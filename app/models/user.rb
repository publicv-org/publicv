class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable, :rememberable,
         :timeoutable, :trackable, :validatable, :confirmable
  mailkick_user

  EMAIL_PREFERENCES = ['email_preference_online_updates'].freeze
  has_one :cv, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :contacts, dependent: :destroy

  has_one :current_location, dependent: :destroy, class_name: 'Location'

  before_validation :sanitize_subdomain

  validates :first_name, :last_name, presence: true
  validates :subdomain, presence: true, uniqueness: true, subdomain: true

  after_initialize :prepare_blank_cv, if: :new_record?

  accepts_nested_attributes_for :cv
  accepts_nested_attributes_for :current_location, reject_if: proc { |attributes|
                                                                attributes['id'].blank? &&
                                                                  attributes['original_address'].blank?
                                                              }

  def cv_public_domain
    domain_suffix = if locale.present?
                      (locale == 'en' ? 'org' : locale)
                    else
                      'org'
                    end
    "#{subdomain}.publicv.#{domain_suffix}"
  end

  def cv_public_url
    "http://#{cv_public_domain}"
  end

  private

  def prepare_blank_cv
    self.cv ||= Cv.new
  end

  def sanitize_subdomain
    self.subdomain = subdomain.squish.strip.downcase.parameterize
  end
end
