# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :roles, String, null: false
    field :points, Integer, null: true
  end
end
  