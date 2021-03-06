require 'rails_helper'

describe 'Authentication', :type => :feature do 

  subject { page }

  describe 'Sign in Page' do 
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end #End Sign in Page

  describe 'general sign in' do 
    before {visit signin_path }

    describe 'with invalid information' do
      before { click_button 'Sign in' }

      it { should have_content("Sign in") }
      it { should have_selector('div.alert-box') }

      describe 'after visiting another page' do 
        before { click_link 'Home' }
        it { should_not have_selector('div.alert-box') }
        it { should_not have_content('error') }  
      end
    end #end invalid info

    describe 'with valid information' do 
      let!(:user) { FactoryGirl.create(:user)}
      before do ####Can be replaced by the sign_in method in spec/utilities
        visit signin_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end
      it { should have_title(user.name) }
      it { should have_link('Users') }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe 'followed by signed out' do
        before { click_link 'Sign out' }

        it { should have_content('Sign in') }
        it { should_not have_content('Sign out')}
      end
    end
    
  end # general signin

  describe 'authorization' do

    describe 'as non-admin user', :type => :request do 
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      before { sign_in non_admin, no_capybara: true }
    

      describe 'submittting a delete request to the Users#destroy action' do 
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end

    describe 'for non signed-in users' do 
      let!(:user) { FactoryGirl.create(:user) }

      describe 'when attempting to visit a protected page' do 
        before do 
          visit edit_user_path(user)
          fill_in 'Email', with: user.email
          fill_in 'Password', with: user.password
          click_button 'Sign in'
        end

        describe 'after signing in' do 
          it 'should render the desired protected page' do 
            expect(page).to have_title("Edit user")
          end
        end
      end

      describe 'in the users controller' do

        describe 'visiting the user index' do 
          before { visit users_path }
          it { should have_title('Sign in') }
          specify {expect(page).to have_content('Sign in')} # extra solo paa testear si funciona
        end

        describe 'visiting the edit page' do 
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end
        describe 'submitting to the update action', :type => :request do 
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

      describe 'in the Microposts controller', :type => :request do 

        describe 'submitting to the create action' do 
          before { post microposts_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe 'submitting to the destroy action' do 
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

    end

    describe 'as wrong user', :type => :request do #Same as :request
      let!(:user) { FactoryGirl.create(:user) }
      let!(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }

      before { sign_in user, no_capybara: true }

      describe 'submitting a get request to the users#edit action' do 
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).to_not match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_path) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end
  end

end #end Authentication