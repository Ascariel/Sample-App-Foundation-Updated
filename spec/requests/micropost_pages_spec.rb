require 'rails_helper'


describe 'Micropost Pages', :type => :feature do 

  subject { page }

  let!(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe 'micropost creation' do 

    before { visit root_path }

    describe 'with invalid information' do 

      it 'should not create a micropost' do 
        expect { click_button 'Post' }.not_to change(Micropost, :count)
      end

      describe 'error_messages' do 
        before { click_button 'Post' }

        it { should have_content('error') }
      end
    end

    describe 'with valid information' do 
      before { fill_in 'micropost_content', with: 'Lorem ipsum' }

      it 'should create micropost' do 
        expect { click_button 'Post' }.to change(Micropost, :count).by(1)
      end
    end

  end

  describe 'micropost destruction' do
    before { FactoryGirl.create(:micropost, user: user) }

    describe 'as correct user' do 
      before { visit root_path }

      it 'should delete i micropost' do 
        expect {click_link 'delete'}.to change(Micropost, :count).by(-1)
      end
    end
  end

end #end





# RSpec.describe "MicropostPages", :type => :request do
#   describe "GET /micropost_pages" do
#     it "works! (now write some real specs)" do
#       get micropost_pages_index_path
#       expect(response.status).to be(200)
#     end
#   end
# end
