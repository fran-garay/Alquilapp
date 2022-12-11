class Reporte < ApplicationRecord
    validates :descripcion, presence: true
    validates :id_usuario, presence: true
    enum type: [:Estado, :Siniestro, :Pagos]
end
