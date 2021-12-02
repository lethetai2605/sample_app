class ReactPost < ApplicationRecord
  belongs_to :micropost
  belongs_to :reaction
  belongs_to :user
end
