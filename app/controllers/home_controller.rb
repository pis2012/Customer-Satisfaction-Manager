class HomeController < ApplicationController

  def index
  end

  def csm_information
  end


  def language_change


    if params[:leng].to_s == "ES"
       I18n.locale = :es
    else
      if params[:leng].to_s == "EN"
        I18n.locale = :en
      end
    end
    respond_to do |format|
      format.html {render "home/index"}
    end
  end


end
