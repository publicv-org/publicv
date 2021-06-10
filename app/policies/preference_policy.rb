class PreferencePolicy < ApplicationPolicy
  def index?
    not_admin?
  end

  def update?
    not_admin?
  end

  def show?
    not_admin?
  end
end
