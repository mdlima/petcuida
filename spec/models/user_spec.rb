# encoding: utf-8

require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
      :name => "Example",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end
  
  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end
  
  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end
  
  
  describe "opt in" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    subject { @user }
    
    it { should respond_to(:opt_in) }
    # it "should have a valid ip address for opt_in_ip"
    
  end
  
  describe "extended sign up attributes" do
    
    before(:each) do
      @extended_attr = {
        last_name: "Last Name",
        phone: "011-99999-9999",
        zip_code: "12345-000"
      }
      
      @extended_attr.merge!(@attr)
      @user = User.create!(@extended_attr)
    end
    
    subject { @user }
    
    it { should be_valid }
    it { should respond_to :last_name       }
    it { should respond_to :phone           }
    it { should respond_to :zip_code        }
    
    describe "validations" do
      
      describe "when phone format is invalid" do
        it "should be invalid" do
          phones = %w[1 111-000 () 123456789 1234567890123 123-4567]
          phones.each do |phone|
            @user.phone = phone
            @user.should_not be_valid
          end
        end
      end

      describe "when phone format is valid" do
        it "should be valid" do
          phones = ['1199999999', '011999999999', '(85)9999-9999', '013-1234-1234', '(021)1234-1234', '(31)12345678', '011 99999 1111']
          phones.each do |phone|
            @user.phone = phone
            @user.should be_valid
          end
        end
      end
      
      
      describe "when zip code format is invalid" do
        it "should be invalid" do
          codes = %w[1 111-000 12345-12 1234-567 123456789]
          codes.each do |code|
            @user.zip_code = code
            @user.should_not be_valid
          end
        end
      end

      describe "when zip code format is valid" do
        it "should be valid" do
          codes = ['12345-123', '12345123', '12345 123']
          codes.each do |code|
            @user.zip_code = code
            @user.should be_valid
          end
        end
      end
      
    end
    
    describe "formatting names" do
      
      before(:each) do
        @test_names = {
          'Test de Lowercase' => 'test de lowercase',
          'Test da Caps' => 'TEST DA CAPS',
          'Test e Test' => 'tEST   E   TEST',
          'Test De-Hifen' => 'test de-hifen',
          'Acentuação Á É À' => 'ACENTUAÇÃO á é à',
          '' => '',
          # nil => nil
        }
      end
      
      it "should format the name" do
        @test_names.each do |key, value|
          @user.name = value
          @user.name.should eq(key)
          @user.should be_valid
        end
      end
      
      it "should format the last name" do
        @test_names.each do |key, value|
          @user.last_name = value
          @user.last_name.should eq(key)
          @user.should be_valid
        end
      end
      
    end
    
  end

end