# encoding: utf-8

class EmailServiceProvider
  def initialize
    @email_provider = Hominid::API.new(ENV["MAILCHIMP_API_KEY"])
  end
  
  def add_user_to_list(user)
    list_id = Rails.env.production? ? "8b1d8c9a12" : "4368979616" # mailchimp.find_list_id_by_name "Pet Cuida - Lançamento"
    info = { "SOURCE" => "website",
             "USER_TYPE" => user.type,
             "TYPE_ID" => (user.type == "Vet") ? 2 : 1,
             "OPTIN_IP" => user.opt_in_ip }
               
    info["FNAME"]    = user.name      if user.name
    info["LNAME"]    = user.last_name if user.last_name
    info["PHONE"]    = user.phone     if user.phone
    info["ZIP_CODE"] = user.zip_code  if user.zip_code
    result = @email_provider.list_subscribe(list_id, user.email, info, 'html', false, true, false, false)
    Rails.logger.info "MAILCHIMP SUBSCRIBE: result #{result.inspect} for #{user}"
  end
  
  def remove_user_from_list(user)
    list_id = Rails.env.production? ? "8b1d8c9a12" : "4368979616" # mailchimp.find_list_id_by_name "Pet Cuida - Lançamento"
    result = @email_provider.list_unsubscribe(list_id, user.email, false, true, true)  
    Rails.logger.info "MAILCHIMP UNSUBSCRIBE: result #{result.inspect} for #{user}"
  end
  
end