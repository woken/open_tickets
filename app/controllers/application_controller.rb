class ApplicationController < ActionController::Base
  require 'tools/response'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Public method that return the type in the that is response the API
  #
  # == Returns:
  # An string whit the type in JSON, XML and YAML
  #
  def get_response_type
    return @respose_type
  end

end
