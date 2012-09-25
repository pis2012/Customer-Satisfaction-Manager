require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  test "no debe guardar el feedback" do
    feed = Feedback.new
    assert !Feedback.save, "Saved the post without a title"
  end


end
