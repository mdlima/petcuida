class UserMailer < ActionMailer::Base
  default :from => "atendimento@petcuida.com.br"
  
  def welcome_email(user)
    mail(:to => user.email, :subject => "Invitation Request Received")
  end
end