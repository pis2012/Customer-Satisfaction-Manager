require 'spec_helper'

class MoodSpec
  describe Mood do
    it "get_mood_img valid" do
      mood = Mood.create(status: 1);

      mood.get_mood_img(1).should eq('1.png')
      mood.get_mood_img(2).should eq('1.png')
      mood.get_mood_img(3).should eq('3.png')
      mood.get_mood_img(4).should eq('3.png')
      mood.get_mood_img(5).should eq('5.png')
      mood.get_mood_img(6).should eq('5.png')
      mood.get_mood_img(7).should eq('7.png')
      mood.get_mood_img(8).should eq('7.png')
      mood.get_mood_img(9).should eq('9.png')
      mood.get_mood_img(10).should eq('9.png')
    end

    it "get_mood_img invalid" do
      pending "Crear test con datos invalidos"
    end
  end
end
