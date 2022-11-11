class Precio < ApplicationRecord
    validates :valor, presence: true
    validates :fecha_de_actualizacion, presence: true
end
