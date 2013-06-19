require 'spec_helper'

describe "rate limiting", type: :api do
  let(:user) { create_user! }

  it "counts the user's requests" do
    expect(user.request_count).to eql(0)

    get '/api/v2/projects.json', token: user.authentication_token
    expect(user.reload.request_count).to eql(1)
  end

  it "stops the user if they have exceeded the rate limit" do
    user.update_attribute(:request_count, 200)
    get '/api/v2/projects.json', token: user.authentication_token
    
    error = {error: "Rate limit exceeded." }
    expect(last_response.status).to eql(403)
    expect(last_response.body).to eql(error.to_json)
  end

end