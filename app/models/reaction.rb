# Reaction
class Reaction < ApplicationRecord
  # frozen_string_literal: true
  has_many :react_posts, dependent: :destroy
end
