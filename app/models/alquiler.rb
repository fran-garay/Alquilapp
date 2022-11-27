class Alquiler < ApplicationRecord
  has_one :auto
  has_one :user
end
