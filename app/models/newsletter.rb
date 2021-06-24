class Newsletter < ApplicationRecord
  has_many :attachments, as: :resource, dependent: :destroy
  has_many :unsubscribes, class_name: 'Mailkick::OptOut', dependent: :destroy

  validates :name, presence: true,
                   format: { with: /\A\w.*\S\z/,
                             message: I18n.t('errors.attributes.name') }
  validates :recipient_ids, presence: true,
                            format: { with: /\A[0-9,\s]+\z/,
                                      message: I18n.t('errors.attributes.recipient_ids') }
  enum status: { failure: 0, success: 1 }
end
