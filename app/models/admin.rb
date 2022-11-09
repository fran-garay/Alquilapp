class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  # validates :email, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  # validates :password, presence: true, length: { minimum: 6, maximum: 50 }
  # validates :password_confirmation, presence: true, length: { minimum: 6, maximum: 50 }
  validates :birth_date, presence: true
  validates :phone, presence: true, length: { minimum: 10, maximum: 10 }
  validate :is_an_adult
  validate :phone_only_contains_numbers


  def is_an_adult
    if birth_date.present? && birth_date > 18.years.ago
      errors.add(:birth_date, "es inválida, debe ser mayor de edad")
    end
  end

  def phone_only_contains_numbers
    if phone.present? && !phone.match?(/\A[+-]?\d+\z/)
      errors.add(:phone, "solo debe contener números")
    end
  end


end
