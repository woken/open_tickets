#encoding: utf-8
class Api::V1::CompanyController < ApplicationController
	
	# Metodo público para obtener el listado de comapanys
	
	def get_companys

		message = "Servicio para listar comapanys"
		status = true

		if Company.exists? then
			comapanys = Company.all
		else
			status = false
			message = "No existen comapanys registradas"
		end
		response = Hash.new
		response[:service] = {service_name: 'Company', endpoint:'get_companys'}
		response[:message] = message
		response[:status] = status
		response[:code] = 200
		response[:data] = comapanys
		render Response.new(self.get_response_type, response[:code]).get_response response	
	end

end