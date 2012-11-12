# encoding: utf-8

class Vet < User

  validates_presence_of :name, :last_name, :phone, :zip_code

end