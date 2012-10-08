require 'test_helper'

class MoodTest < ActiveSupport::TestCase
  test "get_mood_img" do
    mood = Mood.new
    mood.status = 1
    assert mood.get_mood_img == "1.png"
  end
end
