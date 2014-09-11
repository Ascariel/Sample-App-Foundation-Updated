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
      before do 
        visit signin_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end
      it { should have_title(user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe 'followed by signed out' do
        before { click_link 'Sign out' }

        it { should have_content('Sign in') }
        it { should_not have_content('Sign out')}
      end
    end
    
  end # general signin

end #end Authentication