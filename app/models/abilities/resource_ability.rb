module Abilities
  class ResourceAbility
    include CanCan::Ability

    def initialize(user)
      @user = user

      user_abilities
    end

    private

    attr_reader :user

    def user_abilities; end
  end
end
