require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  # unless %w(development test).include? Rails.env
  include SessionsHelper
  include MessagesHelper
  include ResponseHelper
end
