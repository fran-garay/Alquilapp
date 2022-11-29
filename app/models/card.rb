class Card < ApplicationRecord

    validates :name, presence: true
    validates :number, presence: true
    validates :date, presence: true
    validates :cvv, presence: true
    validates :user_id, presence: true
    validates :brand, presence: true

    belongs_to :user

end
