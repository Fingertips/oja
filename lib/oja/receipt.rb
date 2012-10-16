require 'base64'

module Oja
  class Receipt
    attr_accessor :filename, :password
    attr_writer :data

    def initialize(attributes)
      attributes.each do |attribute, value|
        send("#{attribute}=", value)
      end
    end

    def request(environment=:production)
      request = Request.new(
        :receipt     => self,
        :environment => environment
      )
      request.run
    end

    def read
      File.read(filename)
    end

    def data
      @data ||= read
    end

    def receipt_data
      Base64.encode64(data)
    end

    def attributes
      attributes = { 'receipt-data' => receipt_data }
      attributes['password'] = password if password
      attributes
    end

    def to_json
      JSON.dump(attributes)
    end

    def verify
      if response = request(:production)
        if response.sandbox_receipt_in_production?
          request(:sandbox)
        else
          response
        end
      end
    end
  end
end