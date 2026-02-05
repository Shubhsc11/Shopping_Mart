require 'net/https'
require 'uri'
require 'json'

class PaymentsController < ApplicationController
  def add_new_checkout
    byebug
    uri = URI('https://eu-test.oppwa.com/v1/checkouts')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({
      'entityId' => '8a8294174b7ecb28014b9699220015ca',
      'amount' => '92.00',
      'currency' => 'EUR',
      'paymentType' => 'DB'
    })
    res = http.request(req)
    byebug
    return JSON.parse(res.body)
  end

  # puts add_new_checkout
end
