# Ability
class Ability
  # frozen_string_literal: true
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :create, User
      can [:update, :export], User do |usr|
        usr.try(:id) == user.id
      end
      can :create, Micropost
      can [:update, :destroy], Micropost do |micro|
        micro.try(:user) == user
      end
      can :show, User
      can %i[following followers], User
      can :manage, Relationship
    end
  end
end
