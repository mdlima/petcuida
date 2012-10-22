# encoding: utf-8

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :opt_in, :type, :last_name, :phone, :zip_code
  
  after_create :add_user_to_mailchimp unless Rails.env.test?
  before_destroy :remove_user_from_mailchimp unless Rails.env.test?

  # override Devise method
  # no password is required when the account is created; validate password when the user sets one
  validates_confirmation_of :password
  validates_presence_of :email
  def password_required?
    if !persisted?
      !(password != "")
    else
      !password.nil? || !password_confirmation.nil?
    end
  end
  
  # override Devise method
  def confirmation_required?
    false
  end
  
  # override Devise method
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

end