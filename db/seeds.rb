# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#Autos
Auto.destroy_all
Auto.create(patente:"ABC-123", porcentaje_combustible:86.45, estado:"Inhabilitado", modelo:"Ferrari LaFerrari", anio:2022,
     tipo_de_caja:"Manual", tipo_de_combustible:"Gasolina", color:"#FF0000")
Auto.create(patente:"HTR-235", porcentaje_combustible:100, estado:"Disponible", modelo:"McLaren P1", anio:2015,
    tipo_de_caja:"Manual", tipo_de_combustible:"Diesel", color:"#000000")
Auto.create(patente:"JDG-533", porcentaje_combustible:70.2, estado:"Necesita Atencion", modelo:"Sandero" ,anio:2003,
    tipo_de_caja:"Manual", tipo_de_combustible:"Diesel", color:"#151515")
Auto.create(patente:"JOY-256", porcentaje_combustible:60.2, estado:"Disponible", modelo:"Golf", anio:2017,
    tipo_de_caja:"Automatica", tipo_de_combustible:"Diesel", color:"#0058FF")
Auto.create(patente:"KJH-123", porcentaje_combustible:50.2, estado:"Ocupado", modelo:"Clio", anio:2020,
    tipo_de_caja:"Automatica", tipo_de_combustible:"Diesel", color:"#258E3A")
Auto.create(patente:"TGQ-981", porcentaje_combustible:100, estado: "Disponible",modelo:"Megan", anio:2008,
    tipo_de_caja:"Manual", tipo_de_combustible:"Diesel", color:"#A8A560")

#Usuarios
User.destroy_all
Admin.destroy_all

User.create(email: "user@gmail.com", first_name: "Lionel", last_name: "Messi", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), phone: "1234567890", is_being_validated: false)
User.create(email: "en_validacion@gmail.com", first_name: "Juan", last_name: "Perez", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), phone: "1234567890")

Admin.create(email:"super@gmail.com", first_name: "Juana", last_name: "Super", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), is_admin: :false, phone: "1234567890", dni: "12345678")
Admin.create(email:"super2@gmail.com", first_name: "Ernesto", last_name: "Flores", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), is_admin: :false, is_handling_report: :true,
     phone: "1234567890", dni: "87654321")
Admin.create(email:"admin@gmail.com", first_name: "Mario", last_name: "Admin", password: "123456",
    password_confirmation: "123456", birth_date: (Date.new(2001, 11, 18)), is_admin: :true, phone: "1234567890", dni: "12345678")

