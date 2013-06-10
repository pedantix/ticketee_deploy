class Project < ActiveRecord::Base
  attr_accessible :name
 
  has_many :tickets
  has_many :permissions, as: :thing
  
  validates_presence_of :name, message: "Name can't be blank", uniqueness: true

  scope :readable_by, lambda { |user|
    joins(:permissions).where( permissions: { action: "view", 
                          user_id: user.id }) 
  }
end
