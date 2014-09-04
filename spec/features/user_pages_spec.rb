require 'rails_helper'

describe "UserPages", :type => :feature do
	subject {page}

	describe "Sign up page" do 
		before {visit signup_path}

	it {is_expected.to have_content('Sign up')}
	it {is_expected.to have_title(full_title('Sign up'))}

    end
  end

