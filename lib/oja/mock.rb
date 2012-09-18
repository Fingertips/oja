require 'oja/request'
require 'oja/response'

module Oja
  class Mock
    class Response
      attr_reader :status_code, :payload

      def initialize(status_code, payload)
        @status_code = status_code
        @payload = payload
      end

      def ok?
        200 == status_code.to_i
      end

      def body
        JSON.dump(payload)
      end
    end

    class << self
      attr_accessor :responses
    end
    @responses = []

    def self.next_response_arguments
      if responses.empty?
        [200, { status: 0, receipt: {}}]
      else
        responses.pop
      end
    end

    def self.next_response
      Oja::Mock::Response.new(*next_response_arguments)
    end
  end

  class Request
    def response
      @response ||= Oja::Mock.next_response
    end
  end
end