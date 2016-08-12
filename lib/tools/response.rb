# Function is of formatting to the response of the API
#
#
class Response

  # Constante global that define the type of the response
  @@type = nil
  # Constante global that define the response
  @@response = Hash.new
  # Constante global that define the code of response http
  @@status

  # Constructor of the class
  #
  # == Parameters:
  # type::
  #       Define the type of document to response. This can be
  #       xml, json and yaml
  #
  def initialize type = nil, status = nil
    if type.nil?
      @@type = 'json'
    else
      @@type = type
    end

    if status.nil?
      @@status = 401
    else
      @@status = status
    end

    @@response[:api_name] = $service_full_name
    @@response[:service] = ''
    @@response[:format] = @@type
    @@response[:version] = $service_version
    @@response[:code]    = 401
    @@response[:status]  = false
    @@response[:message] = nil
    @@response[:data]    = nil
  end

  # Public method that return a string whit response in format in type
  #
  # == Parameters:
  # data::
  #       Is a data of type hash with the that customize the response
  # == Returns:
  #       Response a string of type that is defined with the type parameter
  #
  def get_response data
    response = ''

    if data.is_a?(Hash)
      case
      when @@type == 'json'
        response = self.get_json data
      when @@type == 'xml'
        response = self.get_xml data
      when @@type == 'yml'
        response = self.get_yml data
      else
        @@response[:format] = 'json'
        response = self.get_json data
      end
    end
    return response
  end

  protected

  # Protected method that return a string in JSON
  #
  # == Parameters:
  # data::
  #       Is a data of type hash with the that customize the response
  # == Returns:
  #       Response a hash whit the structure for the API
  #
  def get_json data
    response = { :json => @@response.merge(data).to_json, :content_type => 'application/json', :status => @@status }
    return response
  end

  # Protected method that return a string in XML
  #
  # == Parameters:
  # data::
  #       Is a data of type hash with the that customize the response
  # == Returns:
  #       Response a hash whit the structure for the API
  #
  def get_xml data
    response = { :xml => @@response.merge(data).to_xml, :content_type => 'application/xml', :status => @@status }
    return response
  end

  # Protected method that return a string in YAML
  #
  # == Parameters:
  # data::
  #       Is a data of type hash with the that customize the response
  # == Returns:
  #       Response a hash whit the structure for the API
  #
  def get_yml data
    response = { :text => @@response.merge(data).to_yaml, :content_type => 'text/yaml', :status => @@status }
    return response
  end
end