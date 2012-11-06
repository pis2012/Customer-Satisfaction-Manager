module ClientsHelper

  def get_client_date
    "#{t("date.#{@client.created_at.strftime("%A")}")} #{@client.created_at.strftime(" %d ")}" + \
    "#{t("date.#{@client.created_at.strftime("%B")}")} #{@client.created_at.strftime(" %Y")}"  + \
    "#{@client.created_at.strftime((" ,  %H:%M"))}"
  end




end
