require 'twilio-ruby' 

class MessagesController < ApplicationController
  def index
    @page_name = "Messages"
  end

  def create
    # put your own credentials here 
    account_sid = '' 
    auth_token = '' 
     
    # set up a client to talk to the Twilio REST API 
    @client = Twilio::REST::Client.new account_sid, auth_token 
     
    @client.account.messages.create({
      from:  '',    
      to:    params[:phone],
      body:  params[:message]
    })
    render :index
  end
end
