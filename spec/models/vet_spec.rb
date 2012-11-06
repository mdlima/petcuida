require 'spec_helper'

describe Vet do
  
  let(:vet) { FactoryGirl.create(:vet) }
  
  subject { vet }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:opt_in) }
  it { should respond_to(:phone) }
  it { should respond_to(:zip_code) }
  
  it { should be_valid }
  
  describe "email tests" do
    describe "when email is not present" do
      before { vet.email = " " }
      it { should_not be_valid }
    end
  
    describe "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          vet.email = invalid_address
          vet.should_not be_valid
        end      
      end
    end

    describe "when email format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          vet.email = valid_address
          vet.should be_valid
        end      
      end
    end
  
    describe "email address with mixed case" do
      let(:mixed_case_email) { "ExAMPle_vET@ExAMPle.CoM" }

      it "should be saved as all lower-case" do
        vet.email = mixed_case_email
        vet.save
        vet.reload.email.should eq(mixed_case_email.downcase)
      end
    end
  
    it "should reject duplicate email addresses" do
      user_with_duplicate_email = vet.dup
      user_with_duplicate_email.should_not be_valid
    end
  
    it "should reject email addresses identical up to case" do
      user_with_duplicate_email = vet.dup
      user_with_duplicate_email.email.upcase!
      user_with_duplicate_email.should_not be_valid
    end
  end
  
  describe "required fields" do

    describe "when name is not present" do
      before { vet.name = '' }
      it { should_not be_valid }
    end

    describe "when phone is not present" do
      before { vet.phone = '' }
      it { should_not be_valid }
    end

    describe "when zip code is not present" do
      before { vet.zip_code = '' }
      it { should_not be_valid }
    end


  end
  
end
