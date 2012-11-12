# encoding: utf-8

class Vet < User

  validates_presence_of :name, :last_name, :phone, :zip_code
  
  private
  
  def send_welcome_email
    TransactionalEmail.new.send_vet_welcome_email(self) unless email.include?('@test.com')
  end


end