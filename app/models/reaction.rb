class Reaction < ApplicationRecord
    has_many :react_posts, dependent: :destroy
end
