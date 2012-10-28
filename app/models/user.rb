# encoding: utf-8

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, 
                  :opt_in, :type, :last_name, :phone, :zip_code
  
  validates_confirmation_of :password
  validates_presence_of :email
  validates :phone,    :format => { with: /^\(?0?(\d{2})\)?[\s-]?(\d{4,5})[- ]*(\d{4})$/ }, :allow_blank => true
  validates :zip_code, :format => { with: /^\d{5}[\s-]?\d{3}$/ }, :allow_blank => true
  
  
  after_create :add_user_to_mailchimp unless Rails.env.test?
  before_destroy :remove_user_from_mailchimp unless Rails.env.test?
  
  after_create :send_welcome_email unless Rails.env.test?
  
  before_save :format_fields
  
  
  # override Devise method
  # no password is required when the account is created; validate password when the user sets one
  def password_required?
    if persisted?
      return (!password.nil? || !password_confirmation.nil?)
    else
      return (password == "")
    end
  end
  
  # override Devise method
  # User confirmation will be delayed until site launch
  def confirmation_required?
    false
  end
  
  # override Devise method
  # Since we disabled user confirmation, we need to make them inactive too
  # or else they would be able to login to the site without e-mail confirmation.
  def active_for_authentication?
    confirmed? || confirmation_period_valid?
  end
  
  # new function to set the password
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end
  
  # new function to determine whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # new function to provide access to protected method pending_any_confirmation
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end
    
  private
  
  def format_fields
    unless self.phone.blank?
      phone_parts = self.phone.gsub(/\D/,'').match(/0?(\d{2})?(\d{4,5})(\d{4})/)
      # => #<MatchData "11999991234" 1:"11" 2:"99999" 3:"1234">
      self.phone = "0#{phone_parts[1]}-#{phone_parts[2]}-#{phone_parts[3]}"
    end
    
    unless self.zip_code.blank?
      zip_parts = self.zip_code.gsub(/\D/,'').match(/(\d{5})(\d{3})/)
      # => #<MatchData "12345012" 1:"12345" 2:"012">
      self.zip_code = "#{zip_parts[1]}-#{zip_parts[2]}"
    end
    
  end

  def add_user_to_mailchimp
    unless self.email.include?('@test.com') # or !self.opt_in?
      mailchimp = Hominid::API.new(ENV["MAILCHIMP_API_KEY"])
      list_id = Rails.env.production? ? "8b1d8c9a12" : "4368979616" # mailchimp.find_list_id_by_name "Pet Cuida - Lançamento"
      info = { 
        "SOURCE" => "website", 
        "USER_TYPE" => self.type, 
        "TYPE_ID" => (self.type == "Owner") ? 1 : 2,
        "OPTIN_IP" => self.opt_in_ip
      }
      info["FNAME"]    = self.name      if self.name
      info["LNAME"]    = self.last_name if self.last_name
      info["PHONE"]    = self.phone     if self.phone
      info["ZIP_CODE"] = self.zip_code  if self.zip_code
      result = mailchimp.list_subscribe(list_id, self.email, info, 'html', false, true, false, false)
      Rails.logger.info("MAILCHIMP SUBSCRIBE: result #{result.inspect} for #{self.inspect}")
    end
  end
  
  def remove_user_from_mailchimp
    unless self.email.include?('@test.com')
      mailchimp = Hominid::API.new(ENV["MAILCHIMP_API_KEY"])
      list_id = Rails.env.production? ? "8b1d8c9a12" : "4368979616" # mailchimp.find_list_id_by_name "Pet Cuida - Lançamento"
      result = mailchimp.list_unsubscribe(list_id, self.email, false, true, true)  
      Rails.logger.info("MAILCHIMP UNSUBSCRIBE: result #{result.inspect} for #{self.email}")
    end
  end
  
  def send_welcome_email
    unless self.email.include?('@test.com')
      mandrill = Mandrill::API.new(ENV["MANDRILL_API_KEY"])
      result = mandrill.messages 'send-template', { 
        :template_name => "Pet Cuida - User Registration Welcome#{Rails.env.production? ? "" : " Dev"}", 
        :template_content => [{ :name => "subject", :content => "Confirmação de Cadastro - Pet Cuida" }], 
        :message => {
          :subject    => "Confirmação de Cadastro - Pet Cuida", 
          :from_email => "atendimento@petcuida.com.br", 
          :from_name  => "Pet Cuida", 
          :to         => [{ :email => self.email, :name => self.name }], 
          :headers    => { "X-MC-GoogleAnalytics" => "www.petcuida.com.br", "X-MC-Tags" => "user-registration-welcome" }, 
          :global_merge_vars => [
            { :name => "SUBJECT", :content => "Confirmação de Cadastro - Pet Cuida" }, 
            { :name => "CURRENT_YEAR", :content => Date.today.year }], 
          :google_analytics_domains => ["www.petcuida.com.br"], 
          :google_analytics_campaign => "welcome_email" }, 
          :async => false }
      Rails.logger.info("MANDRILL WELCOME EMAIL: result #{result.inspect} for #{self.email}")
    end
  end

end