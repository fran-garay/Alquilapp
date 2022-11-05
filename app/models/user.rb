class User < ApplicationRecord
  has_one :wallet
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # User validations
  validates :first_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  # validates :email, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  # validates :password, presence: true, length: { minimum: 6, maximum: 50 }
  # validates :password_confirmation, presence: true, length: { minimum: 6, maximum: 50 }
  validates :birth_date, presence: true
  validate :is_an_adult,

  def is_an_adult
    if birth_date.present? && birth_date > 17.years.ago
      errors.add(:birth_date, "Debes tener al menos 17 años para registrarte")
    end
  end

end
