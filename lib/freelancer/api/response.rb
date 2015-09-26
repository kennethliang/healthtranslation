module Freelancer
  module Api
    class Response

      attr_accessor :payload, :raw_request, :raw_response, :status

      def initialize(request, response)
        @raw_request = request.args[:payload]
        @raw_response = response
        @status = @payload['status']
        @payload = @raw_response['result']
      end

      def success?
        @status == 'success'
      end

      def warning?
        @status
      end

      def failure?
        @status
      end

    end
  end
end

