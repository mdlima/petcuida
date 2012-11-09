# encoding: utf-8

class Vet < User

  validates_presence_of :name, :phone, :zip_code

end