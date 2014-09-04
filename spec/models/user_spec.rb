require 'rails_helper'

describe User, :type => :model do
  before {@user = User.new(name:"Example User", email:"user@example.com",
                 password: "foobar", password_confirmation: "foobar")}
  subject {@user}

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe 'When name is not present' do 
    before { @user.name = " " }

    it { should_not be_valid }
  end
  describe 'When email is not present' do 
    before {@user.email= " "}

    it { should_not be_valid }
  end
  describe 'When name is too long' do 
    before { @user.name = 'a' * 51}

    it { should_not be_valid }
  end
  describe 'When email format is invalid' do
    it 'should not be valid do' do 
      addresses =  %w[user@foo,com user_at_foo.org example.user@foo.
                   foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |email| 
        @user.email = email
        expect(@user).to_not be_valid
      end
    end
  end
  describe 'When user email is valid' do
    it 'should be valid' do 
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |email|
        @user.email = email
        expect(@user).to be_valid
      end
    end
  end
  describe "when email address is already taken" do
   before do
    @user_with_same_email = @user.dup
    @user_with_same_email.email = @user.email.upcase
    @user_with_same_email.save
  end
  it { expect(@user).to_not be_valid }
  end
  describe 'password cant be blank' do
    before { @user = User.new(name:"Example User", email:"user@example.com",
                   password: " ", password_confirmation: " ") }
    it { should_not be_valid }
  end
  describe "passwords doesn't match" do 
    before { @user = User.new(name:"adasd", email: "asasx", password:"1233", password_confirmation: "2435345")  }
    it { should_not be_valid }
  end

  describe 'return value of authenticate method' do 
    before { @user.save }
    let(:found_user) {User.find_by(email: @user.email)}

    describe 'with valid password' do 
      it { should eq found_user.authenticate(@user.password) }
    end
    describe 'with invalid password' do 
      let(:user_for_invalid_password) {found_user.authenticate('invalid') }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey } #syntax change 3.0
      # specify {expect(user_for_invalid_password).to be_false}

    end
    describe 'password length over 6 chars' do 
      before { @user.password = @user.password_confirmation = "a" * 5}
      it { should_not be_valid }
    end
  end

end #content end
    ###### alt syntax ########
    # it { expect(@user.name).to eq('Example User')}
    # it {expect(@user).to respond_to(:name)}
    # subject {@user}
    # it { should respond_to(:name) } IS EQUIVALENT TO...
    # it { is_expected.to respond_to(:name)} IS EQUIVALENT TO...
    # it "alternative test respond_to name" do expect(@user).to respond_to(:name) end
    #### BUT IT {SHOULD} IS WAY SHORTER
  
