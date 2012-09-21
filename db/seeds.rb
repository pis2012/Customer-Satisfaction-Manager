# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Role.delete_all
Client.delete_all

rol_admin = Role.create(name:'Admin')
rol_client = Role.create(name:'Client')
rol_mooveit = Role.create(name:'Mooveit')

client1 = Client.create(name:'MicroHard')

User.create(username: 'admin', full_name:'Martin Cabrera', email:'cabrera@1234.com', role_id:rol_admin.id)
User.create(username: 'client', full_name:'Bill Gates', email:'gates@1234.com', role_id:rol_client.id, client_id:client1.id)
User.create(username: 'mooveit', full_name: 'Jorge Corrales', email:'corrales@1234.com', role_id:rol_mooveit.id)