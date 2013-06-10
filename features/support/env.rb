require 'rubygems'
require 'spork'
require 'cucumber/rails'


Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  ENV["RAILS_ENV"] ||= 'test'
  require 'factory_girl'
  require File.expand_path("../../../config/environment", __FILE__)
  require 'cucumber/rails'

  Capybara.default_selector = :css

end

Spork.each_run do

  ActionController::Base.allow_rescue = false

  Cucumber::Rails::Database.javascript_strategy = :truncation
  FactoryGirl.reload
  begin
    DatabaseCleaner.strategy = :transaction
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end

  DatabaseCleaner.clean

end






