class Notifier < ActionMailer::Base
  default reply_to: "sorbfsu@gmail.com"


  def comment_updated(comment, user)
    @comment = comment
    @user = user
    mail( to: user.email, 
      reply_to:"ticketee <sorbfsu+#{comment.project.id}+#{comment.ticket_id}@gmail.com>",
          from:"ticketee <sorbfsu+#{comment.project.id}+#{comment.ticket_id}@gmail.com>",
       subject: "[ticketee] #{comment.ticket.project.name} - #{comment.ticket.title}" )
  end
end
