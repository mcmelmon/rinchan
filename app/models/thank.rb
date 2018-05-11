class Thank < ApplicationRecord
  belongs_to :user, inverse_of: :thanks
  belongs_to :reply, inverse_of: :thanks
end
