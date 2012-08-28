module Oja
  class Response
    STATUS = {
      0     => :active,
      21000 => :bad_json,
      21002 => :malformed,
      21003 => :authentication_error,
      21004 => :authentication_failed,
      21005 => :service_unavailable,
      21006 => :inactive,
      21007 => :sandbox_receipt_in_production,
      21008 => :production_receipt_in_sandbox
    }

    HUMANIZED_STATUS = {
      0     => 'Active',
      21000 => 'Bad JSON',
      21002 => 'Malformed',
      21003 => 'Authentication Error',
      21004 => 'Authentication Failed',
      21005 => 'Service Unavailable',
      21006 => 'Inactive',
      21007 => 'Sandbox Receipt in Production',
      21008 => 'Production Receipt in Sandbox'
    }

    attr_reader :status_code, :receipt_data

    def initialize(data)
      self.data = data
    end

    def data=(data)
      @status_code  = data['status'].to_i
      @receipt_data = data['receipt']
    end

    def status
      STATUS[status_code]
    end

    def humanized_status
      HUMANIZED_STATUS[status_code]
    end

    STATUS.each do |code, method|
      define_method("#{method}?") do
        status_code == code
      end
    end

    def self.status_code(needle)
      needle = needle.to_sym
      STATUS.each do |status_code, status|
        return status_code if needle == status
      end; nil
    end
  end
end