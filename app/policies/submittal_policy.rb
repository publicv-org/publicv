class SubmittalPolicy < ApplicationPolicy
  def create?
    admin?
  end
end
