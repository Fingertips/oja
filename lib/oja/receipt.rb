require 'base64'

module Oja
  class Receipt
    attr_accessor :data, :filename

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

    def json_data
      data ? JSON.dump(data) : read
    end

    def receipt_data
      Base64.encode64(json_data)
    end

    def to_json
      JSON.dump(
        'receipt-data' => receipt_data
      )
    end

    def verify
      response = request(:production)
      if response.sandbox_receipt_in_production?
        request(:sandbox)
      else
        response
      end
    end

    private

    def data_or_read
      data || File.read(filename)
    end
  end
end