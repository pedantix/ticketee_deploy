
#Given /^"(.*?)" has created a ticket for this project:$/ do |email, table|
 # table.hashes.each do |attributes|
#    FactoryGirl.create(:ticket,
#                        project: @project,
#                        title: attributes[:title],
#                        description: attributes[:description],
#                        user: User.find_by_email!(email))
#  end
#end


Given /^"([^\"]*)" has created a ticket for this project:$/ do |email, table|
  table.hashes.each do |attributes|
    tags = attributes.delete("tags")
    #state = attributes.delete("state")
    ticket = @project.tickets.create!(
      attributes.merge!(:user => 
                          User.find_by_email!(email)))
    #ticket.state = State.find_or_create_by_name(state) if state
    ticket.tag!(tags) if tags
    ticket.save
  end
end

