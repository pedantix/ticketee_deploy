class Project < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name, on: :create, message: "Name can't be blank"
end
