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
client2 = Client.create(name:'Sony')

end_date = DateTime.new(2013,1,1)

p1 = Project.create(client: client2,
                    name: "Panaderia El 10",
                    description: "Software para administracion de una panaderia",
                    end_date: end_date,
                    finalized: false)

date1 = DateTime.new(2012,1,1)
date2 = DateTime.new(2012,3,5)
date3 = DateTime.new(2012,4,7)
date4 = DateTime.new(2012,6,10)
date5 = DateTime.new(2012,8,12)

mood1 = Mood.new
mood1.project = p1
mood1.status = 7
mood1.created_at = date1
mood1.save

mood2 = Mood.new
mood2.project = p1
mood2.status = 3
mood2.created_at = date2
mood2.save

mood3 = Mood.new
mood3.project = p1
mood3.status = 7
mood3.created_at = date3
mood3.save

mood4 = Mood.new
mood4.project = p1
mood4.status = 5
mood4.created_at = date4
mood4.save

mood5 = Mood.new
mood5.project = p1
mood5.status = 9
mood5.created_at = date5
mood5.save


p2 = Project.create(client: client2,
                    name:'Proyecto2',
                    description:'Descripcion de proyecto 2',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p2,
            status: 5)

mood1 = Mood.new
mood1.project = p2
mood1.status = 1
mood1.created_at = date1
mood1.save

mood1 = Mood.new
mood1.project = p2
mood1.status = 9
mood1.created_at = date2
mood1.save

p3 = Project.create(client: client2,
                    name:'Proyecto3',
                    description:'Descripcion de proyecto 3',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p3,
            status: 1)

mood1 = Mood.new
mood1.project = p3
mood1.status = 7
mood1.created_at = date2
mood1.save

mood1 = Mood.new
mood1.project = p3
mood1.status = 9
mood1.created_at = date3
mood1.save

p4 = Project.create(client: client1,
                    name:'Proyecto4',
                    description:'Descripcion de proyecto4',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p4,
            status: 10)

p5 = Project.create(client: client1,
                    name:'Proyecto5',
                    description:'Descripcion de proyecto5',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p5,
            status: 10)

p6 = Project.create(client: client1,
                    name:'Proyecto6',
                    description:'Descripcion de proyecto6',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p6,
            status: 10)

p7 = Project.create(client: client1,
                    name:'Proyecto7',
                    description:'Descripcion de proyecto7',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p7,
            status: 10)

p8 = Project.create(client: client1,
                    name:'Proyecto8',
                    description:'Descripcion de proyecto8',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p8,
            status: 10)

p9 = Project.create(client: client1,
                    name:'Proyecto9',
                    description:'Descripcion de proyecto9',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p9,
            status: 10)

p10 = Project.create(client: client1,
                    name:'Proyecto10',
                    description:'Descripcion de proyecto10',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p10,
            status: 10)

p11 = Project.create(client: client1,
                    name:'Proyecto11',
                    description:'Descripcion de proyecto11',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p11,
            status: 10)

p12 = Project.create(client: client1,
                    name:'Proyecto12',
                    description:'Descripcion de proyecto12',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p12,
            status: 7)

p13 = Project.create(client: client1,
                    name:'Proyecto13',
                    description:'Descripcion de proyecto13',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p13,
            status: 10)

p14 = Project.create(client: client1,
                    name:'Proyecto14',
                    description:'Descripcion de proyecto14',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p14,
            status: 5)

p15 = Project.create(client: client1,
                    name:'Proyecto15',
                    description:'Descripcion de proyecto15',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p15,
            status: 10)

p16 = Project.create(client: client1,
                    name:'Proyecto16',
                    description:'Descripcion de proyecto16',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p16,
            status: 10)

p17 = Project.create(client: client1,
                    name:'Proyecto17',
                    description:'Descripcion de proyecto17',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p17,
            status: 5)

p18 = Project.create(client: client1,
                    name:'Proyecto18',
                    description:'Descripcion de proyecto18',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p18,
            status: 1)

p19 = Project.create(client: client1,
                    name:'Proyecto19',
                    description:'Descripcion de proyecto19',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

Mood.create(project: p19,
            status: 10)

p20 = Project.create(client: client1,
                    name:'Proyecto20',
                    description:'Descripcion de proyecto20',
                    end_date:'2013-01-01 00:00:00',
                    finalized:false)

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

client_usr = User.create(role: rol_client, client: client2,
                         username: 'sony',password:'sony',password_confirmation:'sony',
                         full_name:'Sony', email:'sony@1234.com')

profile2 = Profile.create(user:client_usr, project:p1,
                          last_login_date:'2012-01-01 00:00:00',skype_usr:'gates.skype')

mooveit_usr = User.create(role: rol_mooveit, client: client1,
                          username: 'mooveit',password:'mooveit',password_confirmation:'mooveit',
                          full_name: 'Jorge Corrales', email:'corrales@1234.com')

profile3 = Profile.create(user:mooveit_usr, project:p1,
                          last_login_date:'2012-01-01 00:00:00',skype_usr:'corrales.skype')


Feedback.create



Milestone.create(:target_date => '2011-01-01 00:00:00', :project => p1, :name => "Prueba1")
Milestone.create(:target_date => '2011-02-01 00:00:00', :project => p1, :name => "Prueba2")
Milestone.create(:target_date => '2011-03-01 00:00:00', :project => p1, :name => "Prueba3")
Milestone.create(:target_date => '2011-04-01 00:00:00', :project => p1, :name => "Prueba4")


Milestone.create(:target_date => '2012-04-06 00:00:00', :project => p2, :name => "Proyecto 2, mileston 1")
Milestone.create(:target_date => '2012-05-07 00:00:00', :project => p2, :name => "Proyecto 2, mileston 2")
Milestone.create(:target_date => '2012-06-08 00:00:00', :project => p2, :name => "Proyecto 2, mileston 3")
Milestone.create(:target_date => '2012-07-09 00:00:00', :project => p2, :name => "Proyecto 2, mileston 4")


Milestone.create(:target_date => '2012-05-22 00:00:00', :project => p3, :name => "Proyecto 3, mileston 1")
Milestone.create(:target_date => '2012-06-12 00:00:00', :project => p3, :name => "Proyecto 3, mileston 2")
Milestone.create(:target_date => '2012-08-06 00:00:00', :project => p3, :name => "Proyecto 3, mileston 3")
Milestone.create(:target_date => '2012-08-09 00:00:00', :project => p3, :name => "Proyecto 3, mileston 4")

