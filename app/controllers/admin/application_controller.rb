class Admin::ApplicationController < ApplicationController
  http_basic_authenticate_with name: 'the-admin', password: 'le3me1n'
end
