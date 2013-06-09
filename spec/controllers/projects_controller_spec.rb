require 'spec_helper'

describe ProjectsController do

  it "displays an error for a missing project" do
    get :show, id: "not-here"
    response.should redirect_to(projects_path)
    message = "The project you were looking for could not be found."
    flash[:alert].should eql(message)
  end

  let(:user) do
    user = FactoryGirl.build(:user)
    user.confirm!
    user
  end 

  let(:project) { FactoryGirl.build(:project) }
  context "standard users" do
    { "new" => "get",
      "create" => "post",
      "edit" => "get",
      "update" => "post",
      "destroy" => "delete"}.each do |action, method|
      it "cannot access the new action" do
        sign_in(:user, user)
        send(method, action.dup, id: project.id)
        response.should redirect_to(root_path)
        flash[:alert].should eql("You must be an admin to do that.")    
      end    
    end
  end


end
