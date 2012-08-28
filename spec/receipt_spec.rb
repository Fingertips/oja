require File.expand_path('../preamble', __FILE__)

describe Oja::Receipt do
  it "loads a receipt from disk" do
    receipt = Oja::Receipt.new(:filename => receipt_filename('auto_renewable'))
    JSON.parse(receipt.json_data).should == receipt_data('auto_renewable')
  end

  it "accepts data for a receipt" do
    receipt = Oja::Receipt.new(:data => receipt_data('auto_renewable'))
    JSON.parse(receipt.json_data).should == receipt_data('auto_renewable')
  end
end