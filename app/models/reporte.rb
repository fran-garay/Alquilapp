class Reporte < ApplicationRecord
    has_one :alquiler
    has_one :user
    has_one :admin
    validates :descripcion, presence: true
    validates :user_id, presence: true
    validates :tipo, presence: true
    validates :alquiler_id, presence: true
    validates :title, presence: true
    validates :auto_id, presence: true
    enum tipo: [:Estado, :Siniestro, :Pagos]
    enum status: [:Pendiente, :Atendido, :Finalizado]
end
