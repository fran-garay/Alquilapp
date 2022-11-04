class Wallet < ApplicationRecord
    belongs_to :user
    validate :user_id, presence: true
end
