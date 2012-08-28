require 'oja/receipt'
require 'oja/request'
require 'oja/response'

module Oja
  def self.verify_filename(receipt_filename)
    receipt = Oja::Receipt.new(:filename => receipt_filename)
    receipt.verify
  end
end