require File.expand_path('../preamble', __FILE__)

describe Oja::Receipt do
  it "loads a receipt from disk" do
    receipt = Oja::Receipt.new(:filename => receipt_filename('receipt.txt'))
    receipt.data.should == receipt_data('receipt.txt')
  end

  it "accepts data for a receipt" do
    receipt = Oja::Receipt.new(:data => receipt_data('receipt.txt'))
    receipt.data.should == receipt_data('receipt.txt')
  end

  it "includes the Base64 encoded receipt data in its attributes" do
    data = receipt_data('receipt.txt')
    receipt = Oja::Receipt.new(:data => data)
    receipt.attributes['receipt-data'].should == Base64.encode64(data)
  end

  it "includes the password in its attributes when it's configured" do
    receipt = Oja::Receipt.new(:data => receipt_data('receipt.txt'), :password => 'secret')
    receipt.attributes['password'].should == 'secret'
  end

  it "includes the password in its JSON when it's configured" do
    receipt = Oja::Receipt.new(:data => receipt_data('receipt.txt'), :password => 'secret')
    JSON.parse(receipt.to_json)['password'].should == 'secret'
  end

  it "accepts JSON data as the receipt" do
    receipt = Oja::Receipt.new(:data => receipt_data('receipt.json'), format: :json)
    receipt.data.should == receipt_data('receipt.json')
  end
end
