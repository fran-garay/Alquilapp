class Auto < ApplicationRecord
    validates :patente, presence: true
    validates :modelo, presence: true
    validates :porcentaje_combustible, presence: true
    validates :estado, presence: true
    validates :anio, presence: true
    validates :tipo_de_caja, presence: true
    validates :tipo_de_combustible, presence: true
end
