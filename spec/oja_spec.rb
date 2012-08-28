require File.expand_path('../preamble', __FILE__)
require 'oja/mock'

describe Oja do
  it "verifies an active receipt from disk" do
    response = Oja.verify_filename(receipt_filename('auto_renewable'))
    # The default for the mock response is success
    response.should.be.active
  end

  it "verifies an inactive receipt from disk" do
    Oja::Mock.responses << [200, { status: Oja::Response.status_code(:inactive) }]
    response = Oja.verify_filename(receipt_filename('auto_renewable'))
    response.should.be.inactive
  end

  it "does not return a response when the HTTP request fails" do
    Oja::Mock.responses << [500, {}]
    response = Oja.verify_filename(receipt_filename('auto_renewable'))
    response.should == nil
  end
end