class Project < ActiveRecord::Base
  attr_accessible :name
 
  has_many :tickets

  validates_presence_of :name, message: "Name can't be blank"
end
