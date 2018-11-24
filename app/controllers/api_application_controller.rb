# frozen_string_literal: true

class ApiApplicationController < ActionController::API
  include Response
  include ExceptionHandler
end
