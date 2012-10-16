require 'oja/option_parser'
require 'oja'

module Oja
  class CLI
    def initialize(argv)
      @options, @argv = Oja::OptionParser.parse(argv)
    end

    def usage
      puts "Usage: #{File.basename($0)} <receipt-file> [options]"
      puts ""
      puts "Options"
      puts "  -p, --password <password>"
    end

    def receipt_filename
      @argv[0]
    end

    def password
      @options['p'] || @options['password']
    end

    def print_receipt_details(receipt_data)
      receipt_data.each do |key, value|
        puts "#{key}: #{value}"
      end
    end

    def check_receipt
      if response = Oja.verify_filename(:filename => receipt_filename, :password => password)
        if response.active?
          puts "[!] Receipt appears to be valid and active"
          puts
          print_receipt_details(response.receipt_data)
        else
          puts "[!] Receipt is invalid (#{response.humanized_status})"
        end
      else
        log("[!] Apple Store seems inacessible")
      end
    end

    def run
      if receipt_filename
        check_receipt
      else
        usage
      end
    end

    def log(message)
      $stderr.puts(message)
    end

    def self.run(argv)
      cli = new(argv.dup)
      cli.run
    end
  end
end