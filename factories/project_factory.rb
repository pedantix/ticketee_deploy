FactoryGirl.define do 

  sequence(:id_consecutive) {|n| n}

  factory :project do
    name "Ticketee"
    id { generate(:id_consecutive) }
  end

  factory :ticket do
    title "Make it shiny!"
    description "Gradients! Starbursts! Oh my!"
    user { |u| u.association(:user) }
    project { |p| p.association(:project) }
  end

  factory :comment do
    text "A plain old boring comment."

    ticket { |t| t.association(:ticket) }
    user { |u| u.association(:user) }
  end  

end