class CommentPolicy < ApplicationPolicy
  def destroy?
    user.present? && can_moderate?(user, record)
  end
end