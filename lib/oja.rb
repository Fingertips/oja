require 'oja/receipt'
require 'oja/request'
require 'oja/response'

module Oja
  # Verify a receipt data with the App Store. You can either pass the receipt
  # and password as two arguments or as a option hash.
  #
  # Receipt data should be raw, not Base64 encoded. It usually begins with
  # ‘{ "signature" = ’.
  #
  # Example:
  #   Oja.verify(receipt_data, password)
  #   Oja.verify(:data => receipt_data, :password => password)
  def self.verify(*args)
    receipt = Oja::Receipt.new(argument_hash(*args, [:data, :password]))
    receipt.verify
  end

  # Verify a receipt file with the App Store. You can either pass the filename
  # and password as two arguments or as a option hash.
  #
  # Example:
  #   Oja.verify_filename(filename, password)
  #   Oja.verify(:filename => filename, :password => password)
  def self.verify_filename(*args)
    receipt = Oja::Receipt.new(argument_hash(*args, [:filename, :password]))
    receipt.verify
  end

  private

  def self.argument_hash(*args)
    args  = args.dup
    parts = args.pop
    if args[0].kind_of?(Hash)
      args[0]
    else
      h = {}; parts.each_with_index do |part, index|
        h[part] = args[index]
      end; h
    end
  end
end