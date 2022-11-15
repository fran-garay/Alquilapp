class Auto < ApplicationRecord
    validates :patente, presence: true, uniqueness: true
    validates :modelo, presence: true
    validates :porcentaje_combustible, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates :estado, presence: true
    validates :anio, presence: true, numericality: { greater_than_or_equal_to: 1900, less_than_or_equal_to: 2022 }
    validates :tipo_de_caja, presence: true
    validates :tipo_de_combustible, presence: true
    validates :color, presence: true
    has_one_attached :imagen

    def patente_format
        if birth_date.present? && birth_date > 17.years.ago
          errors.add(:birth_date, "es inválida, debes tener al menos 17 años para registrarte")
        end
      end
end
