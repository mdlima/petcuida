# encoding: utf-8

class Vet < User

  validates_presence_of :name, :last_name, :phone, :zip_code
  
  private
  
  def send_welcome_email
    unless email.include?('@test.com')
      mandrill = Mandrill::API.new(ENV["MANDRILL_API_KEY"])
      result = mandrill.messages 'send-template', 
                                { :template_name => "Pet Cuida - Vet Registration Welcome#{Rails.env.production? ? "" : " Dev"}", 
                                  :template_content => [{ :name => "subject", :content => "Confirmação de Cadastro - Pet Cuida" }], 
                                  :message => { :subject    => "Confirmação de Cadastro - Pet Cuida", 
                                                :from_email => "atendimento@petcuida.com.br", 
                                                :from_name  => "Pet Cuida", 
                                                :to         => [{ :email => email, :name => name }], 
                                                :headers    => { "X-MC-GoogleAnalytics" => "www.petcuida.com.br", "X-MC-Tags" => "user-registration-welcome" }, 
                                                :global_merge_vars => [ { :name => "SUBJECT", :content => "Confirmação de Cadastro - Pet Cuida" }, 
                                                                        { :name => "CURRENT_YEAR", :content => Date.today.year } ], 
                                                :google_analytics_domains => ["www.petcuida.com.br"], 
                                                :google_analytics_campaign => "welcome_email" }, 
                                                :async => false }
      Rails.logger.info "MANDRILL WELCOME EMAIL: result #{result.inspect} for #{email}"
    end
  end


end