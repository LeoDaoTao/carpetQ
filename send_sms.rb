require 'twilio-ruby' 
 
# put your own credentials here 
account_sid = ''
auth_token = ''
 
begin
  # set up a client to talk to the Twilio REST API 
  @client = Twilio::REST::Client.new account_sid, auth_token 
   
  @client.account.messages.create({
    from:  '',
    to:    '',
    body:  'This is a reminder to schedule your Carpet Cleaning appointment.'
  })
rescue Twilio::REST::RequestError => e
      puts e.message
end

