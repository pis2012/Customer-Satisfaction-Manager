module ProjectsHelper

  def get_end_date_project
    td = @project.end_date
    t("date."+"#{td.strftime("%B")}") + " #{td.strftime("%e")}" + ", #{td.strftime("%Y")}"
  end


end
