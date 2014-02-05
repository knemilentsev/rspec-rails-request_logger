require 'coderay'
require 'builder'

module RSpec
  module Rails
    module Loggers

      class HtmlRequestLogger

        #TODO cleanup here
        def initialize(path = nil)
          @path ||= 'public/test-request-result.html'
        end

        def add(*params)
          @logs << RSpec::Rails::RequestLogger::REQUEST_LOG.new(*params)
        end

        def before
          @logs = []
        end

        def replace_files(vars)
          vars.each do |key, value|
            vars[key] = 'Uploaded file' if value.class == Rack::Test::UploadedFile
          end
        end

        def after
          builder = Builder::XmlMarkup.new(:indent => 2)
          html = builder.html {
            builder.head {
               builder.title "API Requests results"
             }
             builder.body {
               builder.h1 "API Requests results"
               @logs.each do |log|
                builder.br
                builder.div do
                 builder.b "#{log.method} #{log.path}"
                 builder.span log.description
                end
                builder.span 'Params:'
                vars = log.vars || {}
                builder << CodeRay.scan(JSON.pretty_generate(replace_files(vars)), :json).div(:line_numbers => nil)
                builder.span 'Response:'
                body = JSON.parse(log.body) || {}
                builder << CodeRay.scan(JSON.pretty_generate(body), :json).div(:line_numbers => nil)
                builder.span "Status:"
                builder.b log.code
                builder.br
               end
             }
           }
          result_file ||= open(@path, 'w')
          result_file << html
        end
      end

    end
  end
end