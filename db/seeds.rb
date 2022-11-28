# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])rails
#   Character.create(name: "Luke", movie: movies.first)

#Autos
Auto.destroy_all
vehiculo = Auto.create(patente:"ABC-123", porcentaje_combustible:86.4, estado:"Inhabilitado", modelo:"Ferrari LaFerrari", anio:2022,
     tipo_de_caja:"Manual", tipo_de_combustible:"Gasolina", color:"#FF0000", location_point: "-34.909680, -57.952094", is_open: false)
vehiculo.imagen.attach(io: File.open('app/assets/images/car_images/Ferrari.jpg'), filename: 'Ferrari.jpg', content_type: 'image/jpg')

vehiculo = Auto.create(patente:"HTR-235", porcentaje_combustible:100, estado:"Disponible", modelo:"McLaren P1", anio:2015,
    tipo_de_caja:"Manual", tipo_de_combustible:"Diesel", color:"#e03412", location_point: "-34.905879, -57.952040", is_open: false)
vehiculo.imagen.attach(io: File.open('app/assets/images/car_images/McLarenP1.jpg'), filename: 'McLarenP1.jpg', content_type: 'image/jpg')

vehiculo = Auto.create(patente:"JDG-533", porcentaje_combustible:70.2, estado:"Necesita Atencion", modelo:"Sandero" ,anio:2003,
    tipo_de_caja:"Manual", tipo_de_combustible:"Diesel", color:"#9e1b02", location_point: "-34.907137, -57.957522", is_open: false)
vehiculo.imagen.attach(io: File.open('app/assets/images/car_images/SanderoRoja.jpg'), filename: 'SanderoRoja.jpg', content_type: 'image/jpg')

vehiculo = Auto.create(patente:"JOY-256", porcentaje_combustible:60.2, estado:"Disponible", modelo:"Golf", anio:2017,
    tipo_de_caja:"Automatica", tipo_de_combustible:"Diesel", color:"#f0dd3a", location_point: "-34.904709, -57.958981", is_open: false)
vehiculo.imagen.attach(io: File.open('app/assets/images/car_images/Golf.jpg'), filename: 'Golf.jpg', content_type: 'image/jpg')

vehiculo = Auto.create(patente:"KJH-123", porcentaje_combustible:50.2, estado:"Ocupado", modelo:"Clio", anio:2020,
    tipo_de_caja:"Automatica", tipo_de_combustible:"Diesel", color:"#FFFFFF", location_point: "-34.901269, -57.957146", is_open: false)
vehiculo.imagen.attach(io: File.open('app/assets/images/car_images/Clio.jpg'), filename: 'Clio.jpg', content_type: 'image/jpg')

vehiculo= Auto.create(patente:"TGQ-981", porcentaje_combustible:100, estado: "Disponible",modelo:"Megan RS", anio:2008,
    tipo_de_caja:"Manual", tipo_de_combustible:"Diesel", color:"#000000", location_point: "-34.909514, -57.956060", is_open: false)
vehiculo.imagen.attach(io: File.open('app/assets/images/car_images/Megane.jpg'), filename: 'Megane.jpg', content_type: 'image/jpg')

# Precios
Precio.destroy_all
Precio.create(valor: 100.56, fecha_de_actualizacion: "2020-12-17")
Precio.create(valor: 200.72, fecha_de_actualizacion: "2020-12-24")
Precio.create(valor: 300.38, fecha_de_actualizacion: "2021-01-01")
Precio.create(valor: 400.24, fecha_de_actualizacion: "2021-03-10")

# Usuarios
User.destroy_all
Admin.destroy_all
Wallet.destroy_all

usuario = User.create(email: "user@gmail.com", first_name: "Lionel", last_name: "Messi", password: "123456",
    password_confirmation: "123456", status: 0, birth_date: (Date.new(2001, 07, 24)), phone: "1234567890", license_valid_until: (Date.new(2022, 12, 10)))
usuario.licencia.attach(io: File.open('app/assets/images/licencias/Leo.png'), filename: 'Leo.png', content_type: 'image/png')

usuario = User.create(email: "en_validacion@gmail.com", first_name: "Luisito", last_name: "Comunica", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), phone: "1234567890", license_valid_until: (Date.new(2024, 12, 31)))
usuario.licencia.attach(io: File.open('app/assets/images/licencias/Luisito.png'), filename: 'Luisito.png', content_type: 'image/png')

usuario = User.create(email: "bloqueado@gmail.com", first_name: "TiniTini", last_name: "Stoessel", password: "123456",
    password_confirmation: "123456", status: 3 ,birth_date: (Date.new(2001, 12, 10)), phone: "1234567890", license_valid_until: (Date.new(2024, 12, 15)))
usuario.licencia.attach(io: File.open('app/assets/images/licencias/Tini.png'), filename: 'Tini.png', content_type: 'image/png')

usuario = User.create(email: "rechazado@gmail.com", first_name: "Elre", last_name: "Chazado", password: "123456",
    password_confirmation: "123456", status: 2 ,birth_date: (Date.new(2001, 05, 18)), phone: "1234567890", license_valid_until: (Date.new(2024, 12, 18)))
#usuario.licencia.attach(io: File.open('app/assets/images/licencias/Tini.png'), filename: 'Tini.png', content_type: 'image/png')

usuario = User.create(email: "estoy_alquilando@gmail.com", first_name: "Estal", last_name: "Quilando", password: "123456",
    password_confirmation: "123456", status: 0 ,birth_date: (Date.new(1959, 05, 18)), phone: "1234567890", license_valid_until: (Date.new(2024, 12, 18)), is_renting: true)
usuario.licencia.attach(io: File.open('app/assets/images/licencias/Tini.png'), filename: 'Tini.png', content_type: 'image/png')

usuario = User.create(email: "backup@gmail.com", first_name: "Rodrigo", last_name: "DePaul", password: "123456",
    password_confirmation: "123456", status: 0 ,birth_date: (Date.new(1992, 05, 18)), phone: "1234567890", license_valid_until: (Date.new(2024, 12, 18)), is_renting: false)
usuario.licencia.attach(io: File.open('app/assets/images/licencias/Tini.png'), filename: 'Tini.png', content_type: 'image/png')

Admin.create(email:"super@gmail.com", first_name: "Juana", last_name: "Super", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), is_admin: :false, phone: "1234567890", dni: "12345678")
Admin.create(email:"super2@gmail.com", first_name: "Ernesto", last_name: "Flores", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), is_admin: :false, is_handling_report: :true,
     phone: "1234567890", dni: "87654321")
Admin.create(email:"admin@gmail.com", first_name: "Mario", last_name: "Admin", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), is_admin: :true, phone: "1234567890", dni: "12345679")

User.all.each do |user|
    Wallet.create(user_id: user.id, saldo: 0, ultima_carga: 0, ultimo_gasto: 0)
end

a = User.find_by(first_name: "Rodrigo")
wal = Wallet.find_by(user_id: a.id)
wal.saldo = 1000000
wal.save
