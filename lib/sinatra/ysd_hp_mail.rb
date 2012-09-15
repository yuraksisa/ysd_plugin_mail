#
# Helpers
#
module Sinatra
 
  module MailHelpers
  
    # Formats the sender address
    def format_sender_address(sender)
    
      (options.mail_include_sender_url)?("<a href=\"#{options.mail_sender_url.gsub('{sender}',sender)}\">#{sender}</a>"):(sender)
    
    end
  
    #
    # Create a block (html + js) to include in a web page to send a message
    #
    def send_message_form(options={})

      erb 'new_message'.to_sym, :layout => false 

    end  
  
  end
  
end
