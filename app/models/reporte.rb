class Reporte < ApplicationRecord
    validates :descripcion, presence: true
    validates :id_usuario, presence: true
    enum tipo: [:Estado, :Siniestro, :Pagos]
end
