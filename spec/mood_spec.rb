require 'spec_helper'

class MoodSpec
  describe Mood do
    it "get_mood_img valid" do
      mood = Mood.create(status: 1);

      Mood.create(status: 1).get_mood_img().should eq('1.png')
      Mood.create(status: 2).get_mood_img().should eq('2.png')
      Mood.create(status: 3).get_mood_img().should eq('3.png')
      Mood.create(status: 4).get_mood_img().should eq('4.png')
      Mood.create(status: 5).get_mood_img().should eq('5.png')
    end

    it "get_graph" do
      Mood.get_graph
    end
  end
end
