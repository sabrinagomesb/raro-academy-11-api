# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
usuario = Usuario.find_by_email('admin@example.com')
if usuario.nil? and Rails.env.development?
  Usuario.create!(nome: 'Administrador', email: 'admin@example.com', password: 'password', password_confirmation: 'password')

  Usuario.create!(nome: 'Paulo Fernandes', email: 'paulo@example.com', password: 'password', password_confirmation: 'password')
end
