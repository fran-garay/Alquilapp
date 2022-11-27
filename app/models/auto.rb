class Auto < ApplicationRecord
    validates :patente, presence: true, uniqueness: true
    validates :modelo, presence: true
    validates :porcentaje_combustible, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates :estado, presence: true
    validates :anio, presence: true, numericality: { greater_than_or_equal_to: 1900, less_than_or_equal_to: 2022 }
    validates :tipo_de_caja, presence: true
    validates :tipo_de_combustible, presence: true
    validates :color, presence: true
    validate :patente_format
    has_one_attached :imagen
    has_many :alquilers, dependent: :destroy

    # make patente validates with a regex
    def patente_format
        if patente.present? && !patente.match?(/\A^[a-zA-Z]{3}-[0-9]{3}$\z/) && !patente.match?(/\A^[a-zA-Z]{2}-[0-9]{3}-[a-zA-Z]{2}$\z/)
            errors.add(:patente, "formato inválido, debe ser AAA-000 o AA-000-AA")
        end
    end
end
