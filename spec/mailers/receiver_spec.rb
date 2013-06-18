require "spec_helper"

describe Receiver do
  let(:project) { FactoryGirl.create(:project)  }
  let(:ticket_owner) { FactoryGirl.create(:user) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project,
                                    user: ticket_owner) }
  let(:commenter) { FactoryGirl.create(:user) }
  let(:comment) do 
    Comment.new( { ticket:ticket, user: commenter, text: "Text Comment" }, without_protection: true )
  end

  it "parses a reply" do
    original = Notifier.comment_updated(comment, ticket_owner)

    reply = Mail.new(
                from: commenter.email,
             subject: "Re: #{original.subject}",
                body: %Q{This is a brand new comment    
                           #{original} },
               to: original.reply_to
      )
      lambda { Receiver.parse(reply) }.should(change(comment.ticket.comments, :count).by(1) )
  end
end
