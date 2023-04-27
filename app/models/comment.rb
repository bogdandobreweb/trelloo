class Comment < ApplicationRecord
  #add validations
  belongs_to :user
  belongs_to :story
end
