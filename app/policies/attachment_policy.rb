class AttachmentPolicy < ApplicationPolicy
  def create?
    admin?
  end
end
