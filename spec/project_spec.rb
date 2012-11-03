require 'spec_helper'

class ProjectSpec
  describe Project do
    it "get_graph" do
      Project.get_graph
    end

    it "distance_between" do
      Project.new.distance_between(0,0)
    end

    it "get_next_milestones" do
      client = Client.create(name:'MicroHard2')
      project = Project.create(client: client,
                                                    name:'Proyecto1',
                                                    description:'proyecto de verificadores',
                                                    end_date:'2013-01-01 00:00:00',
                                                    finalized:false)
      project.get_next_milestones
    end

    it "get_projects_with_no_activity" do
      Project.get_projects_with_no_activity(0)
    end

  end
end