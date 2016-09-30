# frozen_string_literal: true
require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Kuruka
  class Application < Rails::Application
    config.app_generators.scaffold_controller :responders_controller
    config.active_record.observers = :mail_observer
    config.autoload_paths << Rails.root.join('lib')
    config.assets.precompile += %w(404.html 422.html 500.html)
  end
end
