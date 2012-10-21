class MilestonesController < ApplicationController

  before_filter :authenticate_user!

  layout false

  def new_milestone

  end

end
