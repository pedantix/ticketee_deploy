require 'spec_helper'

describe "/api/v2/tickets", type: :api do
  let(:project) { FactoryGirl.create(:project, name: "Ticketee") }
  let(:user) { FactoryGirl.create(:user, admin: true) }

  before do
    user.permissions.create!(action: "view", thing: project)
  end

  let(:token) { user.authentication_token }

  context "index" do
    before do
      5.times do
        FactoryGirl.create(:ticket, project: project, user: user)
      end
    end

    let(:url) { "/api/v2/projects/#{project.id}/tickets"  }

    it "xml" do
      get "#{url}.xml", token: token
      last_response.body.should eql(project.tickets.to_xml)
    end

    it "json" do
      get "#{url}.json", token: token
      last_response.body.should eql(project.tickets.to_json)
    end

  end
end