require 'oja/receipt'
require 'oja/request'
require 'oja/response'

module Oja
  def self.verify(data)
    receipt = Oja::Receipt.new(:data => data)
    receipt.verify
  end

  def self.verify_filename(receipt_filename)
    receipt = Oja::Receipt.new(:filename => receipt_filename)
    receipt.verify
  end
end