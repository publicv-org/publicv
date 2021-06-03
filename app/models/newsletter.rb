class Newsletter < ApplicationRecord
  has_many :attachments, dependent: :restrict_with_exception
  has_one_attached :file
  validates :name, presence: true,
                   format: { with: /\A\w.*\S\z/,
                             message: I18n.t('errors.attributes.name') }
  validates :recipient_ids, presence: true,
                            format: { with: /\A[0-9,\s]+\z/,
                                      message: I18n.t('errors.attributes.recipient_ids') }
end
