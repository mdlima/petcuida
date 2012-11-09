# encoding: utf-8

require 'spec_helper'

describe "StaticPages" do
  
  # describe "Home page" do
  #   # it "should have the content 'Pet Cuida'" do
  #   #   visit '/static_pages/home'
  #   #   page.should have_content('Pet Cuida')
  #   # end
  #   
  #   it "should have the title 'Home'" do
  #     visit '/static_pages/home'
  #     page.should have_selector('title',
  #                       :text => 'Home')
  #   end
  # end
  
  describe "Vets home page" do
    it "should have the title 'Veterinários'" do
      visit '/vets/home'
      page.should have_selector('title',
                        :text => 'Veterinários')
    end
  end
    
end
