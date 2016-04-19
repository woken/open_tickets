# Preview all emails at http://localhost:3000/rails/mailers/ticket_mailer
class TicketMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/ticket_mailer/closed
  def closed
    ticket = Ticket.where(aasm_state: 'closed').first
    TicketMailer.closed(ticket)
  end

end
