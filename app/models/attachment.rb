class Attachment < ApplicationRecord
  belongs_to :newsletter, optional: true
  has_one_attached :file
end
