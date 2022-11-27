class Alquiler < ApplicationRecord
  has_one :auto, dependent: :destroy
  has_one :user, dependent: :destroy
end
