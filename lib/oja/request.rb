require 'rest'
require 'json'

module Oja
  class Request
    ENDPOINT = {
      :production => 'https://buy.itunes.apple.com/verifyReceipt',
      :sandbox    => 'https://sandbox.itunes.apple.com/verifyReceipt'
    }

    attr_accessor :environment, :receipt

    def initialize(attributes)
      attributes.each do |attribute, value|
        send("#{attribute}=", value)
      end
    end

    def endpoint
      ENDPOINT[environment]
    end

    def response
      @response ||= REST.post(endpoint, receipt.to_json)
    end

    def response_data
      JSON.parse(response.body)
    end

    def run
      if response.ok?
        Oja::Response.new(response_data)
      end
    end
  end
end