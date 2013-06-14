class Comment < ActiveRecord::Base
  attr_accessible :text, :ticket_id, :user_id, :state_id

  validates :text, presence: true

  belongs_to :user
  belongs_to :state
  belongs_to :ticket

  delegate :project, to: :ticket 

  after_create :set_ticket_state

private
  def set_ticket_state
    self.ticket.state = self.state
    self.ticket.save!
  end

end
