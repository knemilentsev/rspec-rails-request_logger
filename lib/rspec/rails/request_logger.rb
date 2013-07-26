require "rspec/rails/request_logger/version"
require 'rspec/rails'
require "rspec/rails/example/api_request_example_group"

module RSpec
  module Rails
    module RequestLogger
      REQUEST_LOG = Struct.new(:description, :method, :path, :vars, :headers, :body, :code)
      RSpec.configure do |config|
        config.include RSpec::Rails::ApiRequestExampleGroup, :type => :api_request, :example_group => {
          :file_path => config.escaped_path(%w[spec (api)])
        }

        config.before(:suite) do
          config.request_logger.before
        end
        config.after(:suite) do
          config.request_logger.after
        end
      end
    end
  end
end
