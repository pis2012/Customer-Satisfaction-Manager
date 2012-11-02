module MilestonesHelper

  def get_milestone_date td
    t("date."+"#{td.strftime("%B")}") + " #{td.strftime("%e")}" + ", #{td.strftime("%Y")}"
  end

end
