# frozen_string_literal: true
class Contact
  include ActiveModel::Model
  attr_accessor :name, :email, :message
end
