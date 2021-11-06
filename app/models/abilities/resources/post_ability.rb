module Abilities
  module Resources
    class PostAbility < ResourceAbility
      BASE_PERMISSIONS = %i[read].freeze
      OWNER_PERMISIONS = %i[create delete update].freeze

      private

      def user_abilities
        base_abilities
        owner_abilities
      end

      def base_abilities
        can BASE_PERMISSIONS, Post
      end

      def owner_abilities
        can OWNER_PERMISIONS, Post, { user_id: user.id }
      end
    end
  end
end
