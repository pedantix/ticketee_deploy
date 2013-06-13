class Comment < ActiveRecord::Base
  attr_accessible :text, :ticket_id, :user_id

  validates :text, presence: true

  belongs_to :user
  
end
