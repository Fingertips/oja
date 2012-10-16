require File.expand_path('../preamble', __FILE__)
require 'oja/mock'
require 'oja/cli'

describe Oja::CLI do
  before do
    Peck::Context::Collector.reset!
  end

  it "verifies a receipt from disk" do
    Oja::Mock.responses << [200, { status: Oja::Response.status_code(:active), receipt: { 'product_id' => 'day' }}]
    cli = Oja::CLI.new([receipt_filename('receipt')])
    output = capture_stdout do
      cli.run
    end.to_s
    output.should.include 'Receipt appears to be valid and active'
    output.should.include 'product_id'
  end

  it "allows you to pass a password" do
    cli = Oja::CLI.new([receipt_filename('receipt'), '--password', 'secret'])
    cli.password.should == 'secret'
  end

  it "shows a message when the receipt is invalid" do
    Oja::Mock.responses << [200, { status: Oja::Response.status_code(:inactive) }]
    output = oja(receipt_filename('receipt'))
    output.should.include 'Receipt is invalid (Inactive)'
  end

  private

  def oja(*args)
    capture_stdout do
      Oja::CLI.run(args)
    end
  end
end