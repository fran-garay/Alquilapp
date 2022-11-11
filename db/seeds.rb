# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#Autos
Auto.destroy_all
vehiculo = Auto.create(patente:"ABC-123", porcentaje_combustible:86.4, estado:"Inhabilitado", modelo:"Ferrari LaFerrari", anio:2022,
     tipo_de_caja:"Manual", tipo_de_combustible:"Gasolina", color:"#FF0000")
vehiculo.imagen.attach(io: File.open('app/assets/images/car_images/Ferrari.jpg'), filename: 'Ferrari.jpg', content_type: 'image/jpg')

vehiculo = Auto.create(patente:"HTR-235", porcentaje_combustible:100, estado:"Disponible", modelo:"McLaren P1", anio:2015,
    tipo_de_caja:"Manual", tipo_de_combustible:"Diesel", color:"#e03412")
vehiculo.imagen.attach(io: File.open('app/assets/images/car_images/McLarenP1.jpg'), filename: 'McLarenP1.jpg', content_type: 'image/jpg')

vehiculo = Auto.create(patente:"JDG-533", porcentaje_combustible:70.2, estado:"Necesita Atencion", modelo:"Sandero" ,anio:2003,
    tipo_de_caja:"Manual", tipo_de_combustible:"Diesel", color:"#9e1b02")
vehiculo.imagen.attach(io: File.open('app/assets/images/car_images/SanderoRoja.jpg'), filename: 'SanderoRoja.jpg', content_type: 'image/jpg')

vehiculo = Auto.create(patente:"JOY-256", porcentaje_combustible:60.2, estado:"Disponible", modelo:"Golf", anio:2017,
    tipo_de_caja:"Automatica", tipo_de_combustible:"Diesel", color:"#f0dd3a")
vehiculo.imagen.attach(io: File.open('app/assets/images/car_images/Golf.jpg'), filename: 'Golf.jpg', content_type: 'image/jpg')

vehiculo = Auto.create(patente:"KJH-123", porcentaje_combustible:50.2, estado:"Ocupado", modelo:"Clio", anio:2020,
    tipo_de_caja:"Automatica", tipo_de_combustible:"Diesel", color:"#FFFFFF")
vehiculo.imagen.attach(io: File.open('app/assets/images/car_images/Clio.jpg'), filename: 'Clio.jpg', content_type: 'image/jpg')

vehiculo= Auto.create(patente:"TGQ-981", porcentaje_combustible:100, estado: "Disponible",modelo:"Megan RS", anio:2008,
    tipo_de_caja:"Manual", tipo_de_combustible:"Diesel", color:"#000000")
vehiculo.imagen.attach(io: File.open('app/assets/images/car_images/Megane.jpg'), filename: 'Megane.jpg', content_type: 'image/jpg')

# Precios
Precio.destroy_all
Precio.create(valor: 100.56, fecha_de_actualizacion: "2020-12-17")
Precio.create(valor: 200.72, fecha_de_actualizacion: "2020-12-24")
Precio.create(valor: 300.38, fecha_de_actualizacion: "2021-01-01")
Precio.create(valor: 400.24, fecha_de_actualizacion: "2021-03-10")

# #Usuarios
User.destroy_all
Admin.destroy_all

usuario = User.create(email: "user@gmail.com", first_name: "Lionel", last_name: "Messi", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 07, 24)), phone: "1234567890", is_being_validated: false)
usuario.licencia.attach(io: File.open('app/assets/images/licencias/Leo.png'), filename: 'Leo.png', content_type: 'image/png')
    
usuario = User.create(email: "en_validacion@gmail.com", first_name: "Luisito", last_name: "Comunica", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), phone: "1234567890")
usuario.licencia.attach(io: File.open('app/assets/images/licencias/Luisito.png'), filename: 'Luisito.png', content_type: 'image/png')

Admin.create(email:"super@gmail.com", first_name: "Juana", last_name: "Super", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), is_admin: :false, phone: "1234567890", dni: "12345678")
Admin.create(email:"super2@gmail.com", first_name: "Ernesto", last_name: "Flores", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), is_admin: :false, is_handling_report: :true,
     phone: "1234567890", dni: "87654321")
Admin.create(email:"admin@gmail.com", first_name: "Mario", last_name: "Admin", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), is_admin: :true, phone: "1234567890", dni: "12345679")

