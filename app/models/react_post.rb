# ReactPost
class ReactPost < ApplicationRecord
  # frozen_string_literal: true
  belongs_to :micropost
  belongs_to :reaction
  belongs_to :user
end
