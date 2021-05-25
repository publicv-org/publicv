class Newsletter < ApplicationRecord
  validates :name, presence: true,
                   format: { with: /\A\w.*\S\z/,
                             message: I18n.t('activerecord.errors.models.newsletters.attributes.name') }
  validates :recipient_ids, presence: true,
                            format: { with: /\A[0-9,\s]+\z/,
                                      message: I18n.t(
                                        'activerecord.errors.models.newsletters.attributes.recipient_ids'
                                      ) }
end
