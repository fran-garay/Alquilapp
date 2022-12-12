class Reporte < ApplicationRecord
    has_one :alquiler
    has_one :user
    has_one :admin
    validates :descripcion, presence: true
    validates :id_usuario, presence: true
    validates :tipo, presence: true
    validates :id_alquiler, presence: true
    validates :title, presence: true
    enum tipo: [:Estado, :Siniestro, :Pagos]
end
