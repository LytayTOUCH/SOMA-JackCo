class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.user_group.name == "Administrator"
      can :manage, :all
    else
      can [:create, :read], :all if user.user_group.name == "Data Entry"
      can [:update, :read], :all if user.user_group.name == "Project Leader"
      can :read, :all if user.user_group.name == "Manager"
    end
  end 
  
end
