module Resolvers
  class PostResolver < BaseResolver
    type Types::PostType, null: false
    argument :id, ID

    def resolve(id:)
      ::Post.find(id)
    end
  end
end
