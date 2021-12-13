# Role
class Role < ApplicationRecord
  # frozen_string_literal: true
  has_many :users, dependent: :restrict_with_exception
end
