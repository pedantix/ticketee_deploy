
Given /^"(.*?)" has created a ticket for this project:$/ do |email, table|
  table.hashes.each do |attributes|
    FactoryGirl.create(:ticket,
                        project: @project,
                        title: attributes[:title],
                        description: attributes[:description],
                        user: User.find_by_email!(email))
  end
end

