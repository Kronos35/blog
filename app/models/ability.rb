class Ability
  include CanCan::Ability

  RESOURCES = %i[post].freeze

  def initialize(user)
    RESOURCES.each_with_object(self) do |resource, ability|
      ability_class = "abilities/resources/#{resource}_ability".classify.safe_constantize
      ability.merge ability_class.new(user) if ability_class
    end
  end

  private

  attr_reader :user
end
