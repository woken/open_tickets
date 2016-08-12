#encoding: utf-8
class Api::V1::TicketController < ApplicationController
	
	# Metodo público para obtener el listado de comapanys
	
	def get_tickets

		message = "Servicio para listar Ticket"
		status = true

		if Ticket.exists? then
			comapanys = Ticket.all
		else
			status = false
			message = "No existen Tickets registrados"
		end
		response = Hash.new
		response[:service] = {service_name: 'Ticket', endpoint:'get_tickets'}
		response[:message] = message
		response[:status] = status
		response[:code] = 200
		response[:data] = comapanys
		render Response.new(self.get_response_type, response[:code]).get_response response	
	end

end