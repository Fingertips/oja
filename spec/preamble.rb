require 'bundler/setup'
require 'peck/flavors/vanilla'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'oja'

class Peck::Context
  def receipt_filename(name)
    filename = File.expand_path("../fixtures/receipts/#{name}.json", __FILE__)
    if File.exist?(filename)
      filename
    else
      raise ArgumentError, "There is no receipt fixture with the name `#{name}'"
    end
  end

  def receipt_data(name)
    JSON.parse(File.read(receipt_filename(name)))
  end

  def receipt_as_json(name)
    JSON.dump(receipt_data(name))
  end
end