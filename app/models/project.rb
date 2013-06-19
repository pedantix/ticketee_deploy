class Project < ActiveRecord::Base
  attr_accessible :name
 
  has_many :tickets
  has_many :permissions, as: :thing
  
  validates_presence_of :name, uniqueness: true # message: "Name can't be blank",

  scope :readable_by, lambda { |user|
    joins(:permissions).where( permissions: { action: "view", 
                          user_id: user.id }) 
  }

  def self.for(user)
    user.admin? ? Project : Project.readable_by(user)
  end

  def last_ticket
    tickets.last
  end

end
