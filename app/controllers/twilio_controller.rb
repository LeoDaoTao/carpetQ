class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:messages]
  skip_before_action :require_login, only: [:messages]

  def messages
    response = Twilio::TwiML::Response.new do |r|
      r.Message params["Body"], to: '+19099215297'
    end
    render :xml => response.to_xml
  end
end
