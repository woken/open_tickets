class TicketMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ticket_mailer.closed.subject
  #

  def closed(ticket)
    @ticket = ticket
    mail to: ticket.notified_by.email, from: ticket.created_by.email
  end
end
