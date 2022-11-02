# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])rails
#   Character.create(name: "Luke", movie: movies.first)

Auto.create(patente:"ABC-123", porcentaje_combustible:86.45, estado:"Suspended", modelo:"Ferrari LaFerrari")
Auto.create(patente:"HTR-235", porcentaje_combustible:100, estado:"Activo", modelo:"McLaren P1")
Auto.create(patente:"JDG-533", porcentaje_combustible:70.2, estado:"Activo", modelo:"Sandero")
Auto.create(patente:"JOY-256", porcentaje_combustible:60.2, estado:"Activo", modelo:"Golf")

Admin.create(email:"admin@gmail.com", first_name: "Laureano", last_name: "Admin", password: "12345678", password_confirmation: "12345678", birth_date: (Date.new(2001, 11, 18)), is_admin: :true)
Admin.create(email:"super@gmail.com", first_name: "Francisco", last_name: "Super", password: "12345678", password_confirmation: "12345678", birth_date: (Date.new(2001, 11, 18)), is_admin: :false)
User.create(email: "user@gmail.com", first_name: "Jerónimo", last_name: "User", password: "12345678", password_confirmation: "12345678", birth_date: (Date.new(2001, 11, 18)))