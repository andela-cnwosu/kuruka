# frozen_string_literal: true
require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  include SessionsHelper
  include MessagesHelper
end
