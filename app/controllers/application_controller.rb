class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  private

  # Antes de cada pagina seteo el lenguaje
  def set_locale
    if params[:locale].blank?
      I18n.locale = extract_locale_from_accept_language_header
    else
      if params[:locale] == "es" or params[:locale] == "en"
        I18n.locale = params[:locale]
      end
    end
  end

  # paso el lenguaje por un parametro de la URL para cada cliente
  def default_url_options(options = {})
    {locale: I18n.locale}
  end

  # Obtengo el idioma del browser
  def extract_locale_from_accept_language_header
    browser_locale = request.env['HTTP_ACCEPT_LANGUAGE'].try(:scan, /^[a-z]{2}/).try(:first).try(:to_sym)
    if I18n.available_locales.include? browser_locale
      browser_locale
    else
      I18n.default_locale
    end
  end


  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end


end
