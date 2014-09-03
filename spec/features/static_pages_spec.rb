require 'rails_helper'
# require 'rails_helper'
# require 'capybara/rails'
# 
 
describe "Static pages", :type => :feature do
 

  let!(:base_title) {"Ruby on Rails Tutorial Sample App"}

  subject{page} #allows the use of it should syntax to describe tasks in short

   #applies befeore every test

  describe "Home page" do
    before { visit root_path }
    # visit 'users/new'

    it {is_expected.to have_content('Home')}
    it {is_expected.to have_title(full_title("")), "got #{html}" }
    it {is_expected.not_to have_title(full_title('Home'))}

    # it "should have the content 'Home'" do
    #   visit root_path
    #   expect(page).to have_content('Home'), "expected... got #{html}" 

    end

#     describe "asdads" do
#     it "should display the base_title when :title home is empty" do
#       visit root_path
#       expect(page).to have_title("#{full_title(false)}")

#     end
# end
    # it "should not display Home when :title is empty" do 

    #   visit root_path
    #   expect(page).to_not have_title("| Home"), "expected... got #{html}" 
    # end
  # end

  describe "Help page" do
    before {visit help_path}

    it {is_expected.to have_content('Help')}
    it {is_expected.to have_title(full_title("Help"))}
    it {is_expected.not_to have_content('| Help')}

  #   it "should have the content 'Help'" do
  #     visit help_path
  #     expect(page).to have_content('Help')
  #   end

  #   it "should have the title 'Help'" do
  #     visit help_path
  #     expect(page).to have_title("#{base_title} | Help"), "expected... got #{html}" 
  # end
end

  describe "About page" do

    before {visit about_path}

    it {is_expected.to have_content('About')}
    it {is_expected.to have_title(full_title(""))}
    it {is_expected.not_to have_content('| About')}

    # it "should have the content 'About Us'" do
    #     visit about_path
    #   expect(page).to have_content('About Us')
    # end

    # it "should have the title 'About Us'" do
    #   visit about_path
    #   expect(page).to have_title("#{base_title} | About Us"), "expected... got #{html}" 
    # end

  end

describe "Contact Us page" do 

  before {visit contact_path}

    it {is_expected.to have_content('Contact')}
    it {is_expected.to have_selector('h1', text: 'Contact'), "expecting...got #{html}"}
    it {is_expected.to have_title(full_title(''))}


   #  it "displays Contact content" do 
   #    visit contact_path
   #    expect(page).to have_content("Contact"), "expected... got #{html}" 
   #  end

   #  it "should have title 'Contact" do 

   #    visit contact_path
   #    expect(page).to have_title("#{base_title}"), "expected... got #{html}" 

   #  end
   # end
  end
  
end