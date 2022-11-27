class User < ApplicationRecord
  has_one :wallet
  has_many :alquilers, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # User validations
  validates :first_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :birth_date, presence: true
  validates :phone, presence: true, length: { minimum: 10, maximum: 10 }
  validate :is_an_adult
  validate :phone_only_contains_numbers
  has_one_attached :licencia
  enum status: [:Validado, :Pendiente, :Rechazado, :Bloqueado]

  def is_an_adult
    if birth_date.present? && birth_date > 17.years.ago
      errors.add(:birth_date, "es inválida, debes tener al menos 17 años para registrarte")
    end
  end

  def phone_only_contains_numbers
    if phone.present? && !phone.match?(/\A[+-]?\d+\z/)
      errors.add(:phone, "solo debe contener números")
    end
  end
end
