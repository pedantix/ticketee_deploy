FactoryGirl.define do 

  sequence(:id_consecutive) {|n| n}

  factory :project do
    name "Ticketee"
    id { generate(:id_consecutive) }
  end

  factory :ticket do
    title "Make it shiny!"
    description "Gradients! Starbursts! Oh my!"
  end

end