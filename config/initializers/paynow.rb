#Use this hook to configure the parameters necessary for your payments to work
#Uncomment all the commented configs and use values applicable to your own application
#Paynow credentials can be obtained from the Paynow website 
#Consider using rails credentials for sensitive secrets 
Paynow.setup do |config|

  # ==> Configure Paynow Secrets
  config.integration_id = Rails.application.credentials.paynow[:integration_id]
  config.integration_key = Rails.application.credentials.paynow[:integration_key]

  # ==> Configure Dummy Paynow Urls For now
  config.result_url = "http://www.relay.co.zw/search?q=resulturl"
  config.return_url = "http://www.relay.co.zw/search?q=returnurl"
end
