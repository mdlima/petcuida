require 'spec_helper'

describe "registrations routes" do

  it "should route root to registrations#new" do
    expect(:get => "/").to route_to(
      :controller => "devise/registrations",
      :action => "new")
  end
  
  it "should route /thanks to registrations#thanks" do
    expect(:get => "/thanks").to route_to(
      :controller => "devise/registrations",
      :action => "thanks")
  end
  
  it "should not expose a user list" do
    expect(:get => "/users").not_to be_routable
  end

end