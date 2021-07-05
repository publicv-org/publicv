class Ability
  include CanCan::Ability

  def initialize(current_user)
    guest_permissions
    return unless current_user

    return admin_permissions if current_user.admin?

    user_permissions
  end

  def guest_permissions
    can :manage, Mailkick::OptOut
  end

  def admin_permissions
    can :manage, Newsletter
    can :create, Attachment
  end

  def user_permissions
    can :manage, User
  end
end
