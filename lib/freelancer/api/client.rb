module Freelancer
  module Api
    class Client < ActiveSupport::ProxyObject

      ENDPOINT = 'https://hackathon.syd1.fln-dev.net/api/'
      VERSION = '0.1'

      def initialize(token)
        @token = token
      end

      def url(path)
        "#{ENDPOINT}#{path}"
      end

      def header
        {
            'Freelancer-Developer-Auth-V1': @token,
            'Content-Type': 'application/json'
        }
      end

      def request(path, action, payload, &block)
        response = nil
        ::RestClient.send(action, url(path), payload, header) do |call_response, call_request, result|
          ::Rails.logger.info "Request: #{request.args[:payload]}"
          ::Rails.logger.info "Response: #{call_response}"
          block.call(call_response, call_request, result) if block
          response = Response.new call_request, response
        end
        response
      end

    end
  end
end
