# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application

$service_full_name = "API - 4Talent"
$service_version = "0.0.1"