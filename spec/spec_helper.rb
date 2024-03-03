require "rubygems"
require "bundler"
require "active_record"
require "vcr"
require "debug"

Bundler.require(:default, :development, :test)

Dir[File.join(File.dirname(__FILE__), '../lib/**/*.rb')].each { |f| require f }

# Set up database connection and create database
ENV["DATABASE_URL"] ||= "sqlite3::memory:"
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

RSpec.configure do |config|
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.disable_monkey_patching!

  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.profile_examples = 10

  config.before(:each) do
    ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS shows")
    ActiveRecord::Base.connection.execute("CREATE TABLE shows(id INT, quantity INT, last_update INT)")
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :faraday, :webmock
  c.configure_rspec_metadata!
end
