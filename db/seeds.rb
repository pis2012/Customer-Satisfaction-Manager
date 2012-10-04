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

#Pone en 0 el autoincrement 'id' de las tablas
ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{'roles'}")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{'feedback_types'}")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{'users'}")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{'clients'}")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{'projects'}")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{'milestones'}")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{'moods'}")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{'profiles'}")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{'feedbacks'}")

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

p21 = Project.create(client: client1,
                     name:'Proyecto21',
                     description:'Descripcion de proyecto21',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p21,
            status: 10)

p22 = Project.create(client: client1,
                     name:'Proyecto22',
                     description:'Descripcion de proyecto22',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p22,
            status: 10)

p23 = Project.create(client: client1,
                     name:'Proyecto23',
                     description:'Descripcion de proyecto23',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p23,
            status: 10)

p24 = Project.create(client: client1,
                     name:'Proyecto24',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p24,
            status: 10)

p25 = Project.create(client: client1,
                     name:'Proyecto25',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p25,
            status: 10)

p26 = Project.create(client: client1,
                     name:'Proyecto26',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p26,
            status: 10)

p27 = Project.create(client: client1,
                     name:'Proyecto27',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p27,
            status: 10)

p28 = Project.create(client: client1,
                     name:'Proyecto28',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p28,
            status: 10)

p29 = Project.create(client: client1,
                     name:'Proyecto29',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p29,
            status: 10)

p30 = Project.create(client: client1,
                     name:'Proyecto30',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p30,
            status: 10)

p31 = Project.create(client: client1,
                     name:'Proyecto31',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p31,
            status: 10)

p32 = Project.create(client: client1,
                     name:'Proyecto32',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p32,
            status: 10)

p33 = Project.create(client: client1,
                     name:'Proyecto33',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p33,
            status: 10)

p34 = Project.create(client: client1,
                     name:'Proyecto34',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p34,
            status: 10)

p35 = Project.create(client: client1,
                     name:'Proyecto35',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p35,
            status: 10)

p36 = Project.create(client: client1,
                     name:'Proyecto36',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p36,
            status: 10)

p37 = Project.create(client: client1,
                     name:'Proyecto37',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p37,
            status: 10)

p38 = Project.create(client: client1,
                     name:'Proyecto38',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p38,
            status: 10)

p39 = Project.create(client: client1,
                     name:'Proyecto39',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p39,
            status: 10)

p40 = Project.create(client: client1,
                     name:'Proyecto40',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p40,
            status: 10)

p41 = Project.create(client: client1,
                     name:'Proyecto41',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p41,
            status: 10)

p42 = Project.create(client: client1,
                     name:'Proyecto42',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p42,
            status: 10)

p43 = Project.create(client: client1,
                     name:'Proyecto43',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p43,
            status: 10)

p44 = Project.create(client: client1,
                     name:'Proyecto44',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p44,
            status: 10)

p45 = Project.create(client: client1,
                     name:'Proyecto45',
                     description:'Descripcion de proyecto20',
                     end_date:'2013-01-01 00:00:00',
                     finalized:false)

Mood.create(project: p45,
            status: 10)


admin_usr = User.create(role: rol_admin, client: client1,
                        username: 'admin',password:'admin',password_confirmation:'admin',
                        full_name:'Martin Cabrera', email:'cabrera@1234.com')

profile1 = Profile.create(user:admin_usr, project:p1,
                          last_login_date:'2012-01-01 00:00:00', skype_usr:'martin.skype')

client_usr = User.create(role: rol_client, client: client1,
                         username: 'client_usr',password:'client',password_confirmation:'client',
                         full_name:'Bill Gates', email:'gates@1234.com')

profile = Profile.create(user:client_usr, project:p4,
                          last_login_date:'2012-01-01 00:00:00',skype_usr:'gates.skype')



client_usr = User.create(role: rol_client, client: client2,
                         username: 'sony',password:'sony',password_confirmation:'sony',
                         full_name:'Sony', email:'sony@1234.com')

profile2 = Profile.create(user:client_usr, project:p1,
                          last_login_date:'2012-01-01 00:00:00',skype_usr:'sony.skype')

mooveit_usr = User.create(role: rol_mooveit, client: client1,
                          username: 'mooveit',password:'mooveit',password_confirmation:'mooveit',
                          full_name: 'Jorge Corrales', email:'corrales@1234.com')

profile3 = Profile.create(user:mooveit_usr, project:p1,
                          last_login_date:'2012-01-01 00:00:00',skype_usr:'corrales.skype')


Feedback.create(project: p1, user: client_usr, feedback_type: type_skype, subject: "Email de requerimientos - interfaz", content: " Ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos. Eu sit tincidunt incorrupte definitionem, vis mutat affert percipit cu, eirmod consectetuer signiferumque eu per. In usu latine equidem dolores. Quo no falli viris intellegam, ut fugit veritus placerat per. Ius id vidit volumus mandamus, vide veritus democritum te nec, ei eos debet libris consulatu. No mei ferri graeco dicunt, ad cum veri accommodare. Sed at malis omnesque delicata, usu et iusto zzril meliore. Dicunt maiorum eloquentiam cum cu, sit summo dolor essent te. Ne quodsi nusquam legendos has, ea dicit voluptua eloquentiam pro, ad sit quas qualisque. Eos vocibus deserunt quaestio ei. Blandit incorrupte quaerendum in quo, nibh impedit id vis, vel no nullam semper audiam. Ei populo graeci consulatu mei, has ea stet modus phaedrum. Inani oblique ne has, duo et veritus detraxit. Tota ludus oratio ea mel, offendit persequeris ei vim. Eos dicat oratio partem ut, id cum ignota senserit intellegat. Sit inani ubique graecis ad, quando graecis liberavisse et cum, dicit option eruditi at duo. Homero salutatus suscipiantur eum id, tamquam voluptaria expetendis ad sed, nobis feugiat similique usu ex.")
Feedback.create(project: p1, user: client_usr, feedback_type: type_email, subject: "Conversacion Skype respecto a Integracion Servidores", content: " Ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos. Eu sit tincidunt incorrupte definitionem, vis mutat affert percipit cu, eirmod consectetuer signiferumque eu per. In usu latine equidem dolores. Quo no falli viris intellegam, ut fugit veritus placerat per. Ius id vidit volumus mandamus, vide veritus democritum te nec, ei eos debet libris consulatu. No mei ferri graeco dicunt, ad cum veri accommodare. Sed at malis omnesque delicata, usu et iusto zzril meliore. Dicunt maiorum eloquentiam cum cu, sit summo dolor essent te. Ne quodsi nusquam legendos has, ea dicit voluptua eloquentiam pro, ad sit quas qualisque. Eos vocibus deserunt quaestio ei. Blandit incorrupte quaerendum in quo, nibh impedit id vis, vel no nullam semper audiam. Ei populo graeci consulatu mei, has ea stet modus phaedrum. Inani oblique ne has, duo et veritus detraxit. Tota ludus oratio ea mel, offendit persequeris ei vim. Eos dicat oratio partem ut, id cum ignota senserit intellegat. Sit inani ubique graecis ad, quando graecis liberavisse et cum, dicit option eruditi at duo. Homero salutatus suscipiantur eum id, tamquam voluptaria expetendis ad sed, nobis feugiat similique usu ex.")
Feedback.create(project: p1, user: client_usr, feedback_type: type_email, subject: "Situacion de Formularios", content: " Ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos. Eu sit tincidunt incorrupte definitionem, vis mutat affert percipit cu, eirmod consectetuer signiferumque eu per. In usu latine equidem dolores. Quo no falli viris intellegam, ut fugit veritus placerat per. Ius id vidit volumus mandamus, vide veritus democritum te nec, ei eos debet libris consulatu. No mei ferri graeco dicunt, ad cum veri accommodare. Sed at malis omnesque delicata, usu et iusto zzril meliore. Dicunt maiorum eloquentiam cum cu, sit summo dolor essent te. Ne quodsi nusquam legendos has, ea dicit voluptua eloquentiam pro, ad sit quas qualisque. Eos vocibus deserunt quaestio ei. Blandit incorrupte quaerendum in quo, nibh impedit id vis, vel no nullam semper audiam. Ei populo graeci consulatu mei, has ea stet modus phaedrum. Inani oblique ne has, duo et veritus detraxit. Tota ludus oratio ea mel, offendit persequeris ei vim. Eos dicat oratio partem ut, id cum ignota senserit intellegat. Sit inani ubique graecis ad, quando graecis liberavisse et cum, dicit option eruditi at duo. Homero salutatus suscipiantur eum id, tamquam voluptaria expetendis ad sed, nobis feugiat similique usu ex.")


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

