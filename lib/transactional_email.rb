# encoding: utf-8

class TransactionalEmail
  
  def initialize()
    @email_provider = Mandrill::API.new(ENV["MANDRILL_API_KEY"])
  end
  
  def send_user_welcome_email(user)
    result = @email_provider.messages 'send-template', 
                { :template_name => "Pet Cuida - User Registration Welcome#{Rails.env.production? ? "" : " Dev"}", 
                  :template_content => [{ :name => "subject", :content => "Confirmação de Cadastro - Pet Cuida" }], 
                  :message => { :subject    => "Confirmação de Cadastro - Pet Cuida", 
                                :from_email => "atendimento@petcuida.com.br", 
                                :from_name  => "Pet Cuida", 
                                :to         => [{ :email => user.email, :name => user.name }], 
                                :headers    => { "X-MC-GoogleAnalytics" => "www.petcuida.com.br", 
                                                 "X-MC-Tags" => "user-registration-welcome" }, 
                                :global_merge_vars => [ { :name => "SUBJECT", :content => "Confirmação de Cadastro - Pet Cuida" }, 
                                                        { :name => "CURRENT_YEAR", :content => Date.today.year } ], 
                                :google_analytics_domains => ["www.petcuida.com.br"], 
                                :google_analytics_campaign => "welcome_email" }, 
                                :async => false }
                                              
    Rails.logger.info "MANDRILL WELCOME EMAIL: result #{result.inspect} for User #{user}"
  end
  
  def send_vet_welcome_email(vet)
    result = @email_provider.messages 'send-template', 
                              { :template_name => "Pet Cuida - Vet Registration Welcome#{Rails.env.production? ? "" : " Dev"}", 
                                :template_content => [{ :name => "subject", :content => "Confirmação de Cadastro - Pet Cuida" }], 
                                :message => { :subject    => "Confirmação de Cadastro - Pet Cuida", 
                                              :from_email => "atendimento@petcuida.com.br", 
                                              :from_name  => "Pet Cuida", 
                                              :to         => [{ :email => vet.email, :name => vet.name }], 
                                              :headers    => { "X-MC-GoogleAnalytics" => "www.petcuida.com.br", "X-MC-Tags" => "user-registration-welcome" }, 
                                              :global_merge_vars => [ { :name => "SUBJECT", :content => "Confirmação de Cadastro - Pet Cuida" }, 
                                                                      { :name => "CURRENT_YEAR", :content => Date.today.year } ], 
                                              :google_analytics_domains => ["www.petcuida.com.br"], 
                                              :google_analytics_campaign => "welcome_email" }, 
                                              :async => false }
    Rails.logger.info "MANDRILL WELCOME EMAIL: result #{result.inspect} for Vet #{vet}"
  end
  
end