# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.delete_all
FeedbackType.delete_all
User.delete_all
Client.delete_all
Project.delete_all
Milestone.delete_all
Mood.delete_all
Profile.delete_all
Feedback.delete_all

rol_admin = Role.create(name:'Admin')
rol_client = Role.create(name:'Client')
rol_mooveit = Role.create(name:'Mooveit')

type_skype = FeedbackType.create(name:'Skype')
type_email = FeedbackType.create(name:'Email')
type_reconocimiento = FeedbackType.create(name:'Reconocimiento')
type_comentario = FeedbackType.create(name:'Comentario')

client1 = Client.create(name:'MicroHard')

end_date = DateTime.new(2013,1,1)

p1 = Project.create(client: client1,
                    name:'Panaderia El 10',
                    description:"Software para administracion de una panaderia",
                    end_date: end_date,
                    finalized: false)

Mood.create(project: p1,
            status: 5)
Mood.create(project: p1,
            status: 7)
Mood.create(project: p1,
            status: 9)

p2 = Project.create(client: client1,
                    name:'Proyecto2',
                    description:'Descripcion de proyecto 2',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p2,
            status: 10)

p3 = Project.create(client: client1,
                    name:'Proyecto3',
                    description:'Descripcion de proyecto 3',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p3,
            status: 10)

p4 = Project.create(client: client1,
                    name:'Proyecto4',
                    description:'Descripcion de proyecto4',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p4,
            status: 10)

p5 = Project.create(client: client1,
                    name:'Proyecto5',
                    description:'Descripcion de proyecto5',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p5,
            status: 10)

p6 = Project.create(client: client1,
                    name:'Proyecto6',
                    description:'Descripcion de proyecto6',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p6,
            status: 10)

p7 = Project.create(client: client1,
                    name:'Proyecto7',
                    description:'Descripcion de proyecto7',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p7,
            status: 10)

p8 = Project.create(client: client1,
                    name:'Proyecto8',
                    description:'Descripcion de proyecto8',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p8,
            status: 10)

p9 = Project.create(client: client1,
                    name:'Proyecto9',
                    description:'Descripcion de proyecto9',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p9,
            status: 10)

p10 = Project.create(client: client1,
                    name:'Proyecto10',
                    description:'Descripcion de proyecto10',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p10,
            status: 10)

p11 = Project.create(client: client1,
                    name:'Proyecto11',
                    description:'Descripcion de proyecto11',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p11,
            status: 10)

p12 = Project.create(client: client1,
                    name:'Proyecto12',
                    description:'Descripcion de proyecto12',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p12,
            status: 7)

p13 = Project.create(client: client1,
                    name:'Proyecto13',
                    description:'Descripcion de proyecto13',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p13,
            status: 10)

p14 = Project.create(client: client1,
                    name:'Proyecto14',
                    description:'Descripcion de proyecto14',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p14,
            status: 5)

p15 = Project.create(client: client1,
                    name:'Proyecto15',
                    description:'Descripcion de proyecto15',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p15,
            status: 10)

p16 = Project.create(client: client1,
                    name:'Proyecto16',
                    description:'Descripcion de proyecto16',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p16,
            status: 10)

p17 = Project.create(client: client1,
                    name:'Proyecto17',
                    description:'Descripcion de proyecto17',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p17,
            status: 5)

p18 = Project.create(client: client1,
                    name:'Proyecto18',
                    description:'Descripcion de proyecto18',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p18,
            status: 1)

p19 = Project.create(client: client1,
                    name:'Proyecto19',
                    description:'Descripcion de proyecto19',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p19,
            status: 10)

p20 = Project.create(client: client1,
                    name:'Proyecto20',
                    description:'Descripcion de proyecto20',
                    end_date:'2013-01-01 00:00:00',
                    finalized:FALSE)

Mood.create(project: p20,
            status: 10)


admin_usr = User.create(role: rol_admin, client: client1,
                        username: 'admin',password:'admin',password_confirmation:'admin',
                        full_name:'Martin Cabrera', email:'cabrera@1234.com')

profile1 = Profile.create(user:admin_usr, project:p1,
                          last_login_date:'2012-01-01 00:00:00', skype_usr:'martin.skype')

client_usr = User.create(role: rol_client, client: client1,
                         username: 'client_usr',password:'client',password_confirmation:'client',
                         full_name:'Bill Gates', email:'gates@1234.com')

profile2 = Profile.create(user:client_usr, project:p1,
                          last_login_date:'2012-01-01 00:00:00',skype_usr:'gates.skype')

mooveit_usr = User.create(role: rol_mooveit, client: client1,
                          username: 'mooveit',password:'mooveit',password_confirmation:'mooveit',
                          full_name: 'Jorge Corrales', email:'corrales@1234.com')

profile3 = Profile.create(user:mooveit_usr, project:p1,
                          last_login_date:'2012-01-01 00:00:00',skype_usr:'corrales.skype')


Milestone.create(:target_date => '2011-01-01 00:00:00', :project => p1, :name => "Prueba1")
Milestone.create(:target_date => '2011-02-01 00:00:00', :project => p1, :name => "Prueba2")
Milestone.create(:target_date => '2011-03-01 00:00:00', :project => p1, :name => "Prueba3")
Milestone.create(:target_date => '2011-04-01 00:00:00', :project => p1, :name => "Prueba4")




