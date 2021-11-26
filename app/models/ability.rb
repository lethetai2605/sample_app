# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can :read, User do |user|
          user.try(:id) == user.id
        end
        can :update, User do |user|
          user.try(:id) == user.id
        end
        can :create, Micropost
        can :update, Micropost do |micro|
          micro.try(:user) == user
        end
        can :destroy, Micropost do |micro|
          micro.try(:user) == user
        end
      end
  end
end
