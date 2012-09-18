require File.expand_path('../preamble', __FILE__)

describe Oja::Receipt do
  it "loads a receipt from disk" do
    receipt = Oja::Receipt.new(:filename => receipt_filename('receipt'))
    receipt.data.should == receipt_data('receipt')
  end

  it "accepts data for a receipt" do
    receipt = Oja::Receipt.new(:data => receipt_data('receipt'))
    receipt.data.should == receipt_data('receipt')
  end
end