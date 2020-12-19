class Post < ApplicationRecord
  validates(:content, presence: true, length: { maximum: 200 })
end
