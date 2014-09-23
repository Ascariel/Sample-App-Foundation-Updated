require 'rails_helper'

describe 'Static Pages' , :type => :feature do

  subject { page } #allows the use of it should syntax to describe tasks in short

  shared_examples_for 'all static pages' do #this block applies to the test that call it whith 
    it { should have_selector( 'h1', text: heading) } #it_should_behave_like 'all static pages'
    it { should have_title(full_title(page_title)) }
  end


  describe 'Home page' do
    before { visit root_path }
    let!(:heading) {"Sample App"}
    let!(:page_title) {''}

    it_should_behave_like 'all static pages' do #here im calling the predefined it shoulds in shared_examples
      it {should_not have_title(full_title('| Home'))}
    end

    describe 'for signed in users' do 
      let!(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: 'Lorem ipsum' )
        FactoryGirl.create(:micropost, user: user, content: 'Dolor sit amet')
        sign_in user
        visit root_path
      end

      it 'should render the users feed' do 
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content) 
        end
      end
    end

  end

  describe 'Help page' do
    before {visit help_path}
    let!(:heading) {"Help"}
    let!(:page_title) { 'Help' }

    it_should_behave_like 'all static pages'
  end

  describe 'About page' do
    before { visit about_path }
    let!(:heading) { 'About' }
    let!(:page_title) { 'About' }

    it_should_behave_like 'all static pages'
  end

  describe 'Contact page' do
    before { visit contact_path }
    let!(:heading) { 'Contact' }
    let!(:page_title) { 'Contact' }

    it_should_behave_like 'all static pages'
  end

  before {visit root_path}
  it 'should have the right links on the layout' do 
    
    # visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About'))

    # visit root_path
    click_link "Help"
    expect(page).to have_title(full_title("Help"))

    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))

    click_link('Home')
    expect(page).to_not have_title(full_title("Home"))

    click_link('Sample App')
    expect(page).to have_title(full_title(""))

    click_link("Sign Up Now!")
    expect(page).to have_title(full_title("Sign up"))
  end

end











# require 'rails_helper'
# # require 'rails_helper'
# # require 'capybara/rails'
# # 
 
# describe "Static pages", :type => :feature do
 

#   # let!(:base_title) {"Ruby on Rails Tutorial Sample App"}

#   subject{page} #allows the use of it should syntax to describe tasks in short
#    #applies befeore every test

#   describe "Home page" do
#     before { visit root_path }

#     it {is_expected.to have_content('Home')}
#     it {is_expected.to have_title(full_title("")), "got #{html}" }
#     it {is_expected.not_to have_title(full_title('Home'))}

#     end

#   describe "Help page" do
#     before {visit help_path}

#     it {is_expected.to have_content('Help')}
#     it {is_expected.to have_title(full_title("Help"))}
#     it {is_expected.not_to have_content('| Help')}

# end

#   describe "About page" do

#     before {visit about_path}

#     it {is_expected.to have_selector('h1', text: 'About')}
#     it {is_expected.to have_title(full_title(""))}
#     it {is_expected.not_to have_content('| About')}

#   end

# describe "Contact page" do 

#   before {visit contact_path}

#     it {is_expected.to have_content('Contact')}
#     it {is_expected.to have_selector('h1', text: 'Contact'), "expecting...got #{html}"}
#     it {is_expected.to have_title(full_title(''))}

#   end
  
# end

