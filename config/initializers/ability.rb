class Ability
  include CanCan::Ability

  def initialize member
    member ||= Member.new
    if admin_members.include? member.id
      can :manage, :all
    else
      can :manage, Birthday
    end
  end
  
  def admin_members
    ENV['ADMIN_MEMBERS'].split(',').map(&:to_i)
  end
end
