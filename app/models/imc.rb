class Imc < ApplicationRecord
  with_options presence: true do
    validates :height, :weight
    end
end
