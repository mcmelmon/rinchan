class Demurral < ApplicationRecord
  belongs_to :user, inverse_of: :demurrals
  belongs_to :reply, inverse_of: :demurrals
end

