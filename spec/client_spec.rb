require 'spec_helper'

class ClientSpec
  describe Client do
    it "testear no borrar cliente cuando tiene asignado usuario" do
      client = Client.new
      client.name = "admin"
      client.name.should eq("admin")

      client1 = Client.create(name:'MicroHard')
      rol_admin = Role.create(name:'Admin')

      admin_usr = User.create(role: rol_admin, client: client1,
                              username: 'admin',password:'admin',password_confirmation:'admin',
                              full_name:'Martin Cabrera', email:'cabrera@1234.com')

      client1.destroy

      Client.find_all_by_name('MicroHard').size.should eq(1)


    end


    it "testear no borrar cliente cuando tiene asignado proyecto" do


      client1 = Client.create(name:'MicroHard2')


      project2 = Project.create(client: client1,
                           name:'Proyecto2',
                           description:'proyecto de verificadores',
                           end_date:'2013-01-01 00:00:00',
                           finalized:false)

      client1.destroy

      Client.find_all_by_name('MicroHard').size.should eq(1)


    end

  end
end