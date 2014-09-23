FactoryGirl.define do 
#   factory :user do
#     # name     "Michael Hartl"
#     # email    "michael@example.com"
#     # password "foobar"
#     # password_confirmation "foobar"

#   end
# end  
  factory :user do
    sequence :name  do |n| "Person #{n}" end  #same as:
    sequence(:email) { |n| "person_#{n}@example.com"} #same 
    password "foobar"
    password_confirmation "foobar"
    
    factory :admin do 
      admin true
    end
  end
  factory :micropost do 
    content 'Lorem ipsum'
    user  #associates the miropost to its owner user
  end
end