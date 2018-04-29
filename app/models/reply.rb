class Reply < ApplicationRecord
  belongs_to :user, inverse_of: :replies
  belongs_to :topic, inverse_of: :replies

  validates_presence_of :body
end
