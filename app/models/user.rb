class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :timeoutable, :trackable, :validatable, :confirmable

  has_one :cv, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :call_logs, dependent: :destroy
  has_many :sms_logs, dependent: :destroy


  has_one :current_location, dependent: :destroy, class_name: 'Location'

  validates :first_name, :last_name, :subdomain, presence: true
  validates :subdomain, uniqueness: true
  validates :subdomain, format: {
    with: /\A[A-Za-z0-9](?!.*--)(?:[A-Za-z0-9\-]{0,61}[A-Za-z0-9])?\z/i, message: 'not a valid subdomain'
  }

  after_initialize :prepare_blank_cv, if: :new_record?
  before_validation :downcase_subdomain

  accepts_nested_attributes_for :cv
  accepts_nested_attributes_for :current_location, reject_if: proc { |attributes| attributes['id'].blank? && attributes['original_address'].blank? }

  def cv_public_domain
    domain_suffix = locale.present? ? (locale == 'en' ? 'org' : locale) : 'org'
    "#{subdomain}.publicv.#{domain_suffix}"
  end

  def cv_public_url
    "http://#{cv_public_domain}"
  end

  def this_month_sms_logs
    self.sms_logs.where(created_at: Date.today.beginning_of_month..Date.today.end_of_month)
  end

  def this_month_outgoing_sms_logs
    this_month_sms_logs.where.not(sms_status: ["received"])
  end

  def this_month_incomming_sms_logs
    this_month_sms_logs.where(sms_status: "received")
  end

  private

  def prepare_blank_cv
    self.cv ||= Cv.new
  end

  def downcase_subdomain
    self.subdomain = subdomain.downcase
  end

end
