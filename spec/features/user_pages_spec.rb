require 'rails_helper'

describe "UserPages", :type => :feature do
	subject {page}

  describe 'profile page' do 
    let!(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name)  }
    it { should have_title(user.name), html }
  end

	describe "Sign up page" do 
		before {visit new_user_path}

  	it {is_expected.to have_content('Sign up')}
  	it {is_expected.to have_title(full_title('Sign up'))}

  end

  describe 'sign up' do 
    before { visit new_user_path}
    let(:submit) {"Create my account"}

    describe 'fail with invalid data' do 
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count) #count is applied before and after the block that preceeds it, so before and after clicking the button  
      end
    describe "after failed submit" do
      before {click_button submit}
      it { should have_content("Sign up") }
      it { should have_content("errors") }
     end
    end # end fail invalid data
  # end

    describe 'succeed on valid data' do 
      before do
        fill_in 'Name', with: "Example User"
        fill_in 'Email', with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Password confirmation", with: "foobar"
        ###### Can ue Id, Or Label to anchor the fill_in
      end
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving user" do
          before {click_button submit}
          let!(:user) { User.find_by(email: "user@example.com") }

          it { should have_content(user.name) }
          it { expect(have_selector('div', text: 'Welcome to our Tweeter App'))}
          it { should have_link('Sign out'), html }

         
      end # end after saving user
    end # end succeed on valid data
  end # end signup

end #end user pages

