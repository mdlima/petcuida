# encoding: utf-8

class User < ActiveRecord::Base

  after_initialize :init
  
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
  validates :zip_code, :format => { with: /^\d{5}[\s-]?\d{3}$/ }, :allow_blank => true
  validate :phone_number_validation
  
  after_create :add_user_to_email_list unless Rails.env.test?
  before_destroy :remove_user_from_email_list unless Rails.env.test?
  
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
    update_attributes p
  end
  
  # new function to determine whether a password has been set
  def has_no_password?
    encrypted_password.blank?
  end

  # new function to provide access to protected method pending_any_confirmation
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end
  
  def name= (nm)
    write_attribute(:name, format_name(nm))
  end
  
  def last_name= (nm)
    write_attribute(:last_name, format_name(nm))
  end
  
  def to_s
    "#{name} <#{email}>"
  end
  
    
  private

  NAME_CAPS_EXCEPTIONS = %w[da das de des di dis do dos du dus e]
  
  def init
    self.opt_in = true if has_attribute?(:opt_in) && opt_in.nil?
  end
  
  def format_name (nm)
    return nm if nm.blank?
    nm.strip.squeeze(' ').split('-').map do |part|
      part.nome_proprio
    end.join('-')
  end
  
  def format_fields
    unless phone.blank?
      phone_parts = phone.gsub(/^[0\D]+|[\D]+/,'').match(/(\d{2})(\d{4,5})(\d{4})/)
      # => #<MatchData "11999991234" 1:"11" 2:"99999" 3:"1234">
      self.phone = "0#{phone_parts[1]}-#{phone_parts[2]}-#{phone_parts[3]}"
    end
    
    unless zip_code.blank?
      zip_parts = zip_code.gsub(/\D/,'').match(/(\d{5})(\d{3})/)
      # => #<MatchData "12345012" 1:"12345" 2:"012">
      self.zip_code = "#{zip_parts[1]}-#{zip_parts[2]}"
    end
  end
  
  def phone_number_validation
    unless phone.blank?
      # Keeps just numbers with no leading zeroes
      phone_number = phone.gsub(/^[0\D]+|[\D]+/,'')
      errors.add(:phone,"é muito curto, lembre-se de colocar o DDD.") if phone_number.length < 10
      errors.add(:phone,"é muito longo, utilize o formato 011-99999-9999.") if phone_number.length > 11
    end
  end

  def add_user_to_email_list
    EmailServiceProvider.new.add_user_to_list(self) unless email.include?('@test.com') or !opt_in?
  end
  
  def remove_user_from_email_list
    EmailServiceProvider.new.remove_user_from_list(self) unless email.include?('@test.com')
  end
  
  def send_welcome_email
    TransactionalEmail.new.send_user_welcome_email(self) unless email.include?('@test.com')
  end

end