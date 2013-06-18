require "spec_helper"

describe Notifier do

  let(:project) { FactoryGirl.create(:project) }
  let(:ticket_owner) { FactoryGirl.create(:user) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: ticket_owner) }
  let(:commenter) { FactoryGirl.create(:user) }
  let(:comment) { FactoryGirl.build(:comment, ticket:ticket, user: commenter) }
  let(:mail) {Notifier.comment_updated(comment, ticket_owner)  }

  it "correctly sets the reply-to" do
    mail.reply_to.should eql(["sorbfsu+#{comment.project.id}" +
                  "+#{comment.ticket.id}@gmail.com"])
  end
end
