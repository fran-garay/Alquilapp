class Auto < ApplicationRecord
    validates :patente, presence: true, uniqueness: true
    validates :modelo, presence: true
    validates :porcentaje_combustible, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates :estado, presence: true
    validates :anio, presence: true, numericality: { greater_than_or_equal_to: 1900, less_than_or_equal_to: 2022 }
    validates :tipo_de_caja, presence: true
    validates :tipo_de_combustible, presence: true
    validates :color, presence: true
end
