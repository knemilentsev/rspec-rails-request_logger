require 'rspec/rails/loggers/html_request_logger'

RSpec.configure do |config|
  config.add_setting :request_logger, default: RSpec::Rails::Loggers::HtmlRequestLogger.new
end

module RSpec::Rails
  module ApiRequestExampleGroup
    extend ActiveSupport::Concern
    include RSpec::Rails::RequestExampleGroup

    included do
      metadata[:type] = :api_request
    end

    def logger
      @logger ||= RSpec.configuration.request_logger
    end

    def get(*opts)
      log_request(opts) do
        super
      end
    end

    def post(*opts)
      log_request(opts) do
        super
      end
    end

    def put(*opts)
      log_request(opts) do
        super
      end
    end

    def delete(*opts)
      log_request(opts) do
        super
      end
    end

    def log_request(opts, &block)
      desc = example.description
      path, vars, headers = *opts
      yield opts
      method = request.request_method
      body = response.body
      code = response.code
      logger.add desc, method, path, vars, headers, body, code
    end
  end
end