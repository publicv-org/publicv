class Attachment < ApplicationRecord
  belongs_to :resource, polymorphic: true, optional: true
  has_one_attached :file
end
