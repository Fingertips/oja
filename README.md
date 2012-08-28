# Oja

Oja is a Ruby client for verification of Apple Store Receipts.

iOS and Mac application receive Receipts when handling purchases from the App Store. Before authorizing access to in-app content, these applications need to verify the receipt with Apple. Oja helps you check the Receipt's status.

## Install

    $ gem install oja

## Get started

    response = Oja.verify(:data => data)
    if response.active?
      # Whatever you need to do
    elsif response.inactive?
      # The receipt probably expired
    else
      raise RuntimeError, response.humanized_status
    end