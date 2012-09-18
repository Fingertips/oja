require 'bundler/setup'
require 'peck/flavors/vanilla'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'oja'

class Peck::Context
  def receipt_filename(name)
    filename = File.expand_path("../fixtures/receipts/#{name}.txt", __FILE__)
    if File.exist?(filename)
      filename
    else
      raise ArgumentError, "There is no receipt fixture with the name `#{name}'"
    end
  end

  def receipt_data(name)
    File.read(receipt_filename(name))
  end
end