#
# Middleware functionality
#
module Sinatra
  
 module Mail
    
   def self.registered(app)
      
     # Add the local folders to the views and translations     
     app.settings.views = Array(app.settings.views).push(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'views')))
     app.settings.translations = Array(app.settings.translations).push(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'i18n')))       
                        
     # Configure a before filter to initialize the session attribute mailbox with the user name of the connected user 
     app.before do
   
       if user
	     session[:mailbox] = user['username'] unless session[:mailbox]   
         puts "MailBox : #{session[:mailbox]} user: #{user['username']} path : #{request.path_info}" 
       else
         session.delete(:mailbox) if session[:mailbox]
         puts "deleted mailbox from session (No user connected) #{request.path_info}"
       end
   
     end
   
   end
   
 end #SocialMail
end #Sinatra
