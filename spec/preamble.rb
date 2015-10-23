$:.unshift File.expand_path('../../lib', __FILE__)
require 'oja'

require 'bundler/setup'
require 'peck/flavors/vanilla'

class Peck::Context
  class Collector
    attr_accessor :written

    def self.instance
      @instance ||= new
    end

    def initialize
      reset!
    end

    def puts(line=nil)
      @written << "#{line}\n"
    end

    def write(line=nil)
      @written << line
    end

    def to_s
      @written.join("\n")
    end

    def reset!
      @written = []
    end

    def self.reset!
      instance.reset!
    end
  end

  def receipt_filename(name)
    filename = File.expand_path("../fixtures/receipts/#{name}", __FILE__)
    if File.exist?(filename)
      filename
    else
      raise ArgumentError, "There is no receipt fixture with the name `#{name}'"
    end
  end

  def receipt_data(name)
    File.read(receipt_filename(name))
  end

  def capture_stdout(&block)
    stdout = $stdout
    $stdout = Collector.instance
    Collector.reset!
    block.call
  ensure
    $stdout = stdout
    return Collector.instance.to_s
  end
end