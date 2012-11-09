# require 'spec_helper'
# 
# describe "robots.txt routes" do
# 
#   it "should route /robots.txt to roboto" do
#     expect(:get => "/robots.txt").to be_routable
#   end
#   
#   it "should respond to /robots.txt" do
#     get '/robots.txt'
#     response.status.should be(200)
#   end
#   
#   it "should block crawling on test environment" do
#     get '/robots.txt'
#     response.should have_content('Disallow: *')
#   end
# 
# end