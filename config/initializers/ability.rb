class Ability
  include CanCan::Ability

  def initialize member
    member ||= Member.new
    if ENV['ADMIN_MEMBERS'].split(',').include? member.id
      can :manage, :all
    else
      can :manage, Birthday
    end
  end
end
