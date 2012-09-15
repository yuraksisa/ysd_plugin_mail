module Sinatra
  module YSD
    #
    # Mail application for Sinatra
    # 
    # Configuration:
    #
    #   - mail_sender_url: The url format to access the sender page
    #   - mail_include_sender_url: Include the sender url in the message header
    #
    #
    module Mail
   
      def self.registered(app)
      
        # Configuration
        #
        app.set :mail_include_sender_url, false
        app.set :mail_sender_url, ''
        
        # Add the local folders to the views and translations     
        app.settings.views = Array(app.settings.views).push(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'views')))
        app.settings.translations = Array(app.settings.translations).push(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'i18n')))       
     
        #
        # Messages reader
        #
        app.get "/mail/messages-reader" do
     
           load_page 'message-reader'.to_sym  
     
        end
       
        #
        # Serves static content from the extension
        #
        app.get "/mail/*" do
            
           serve_static_resource(request.path_info.gsub(/^\/mail/,''), File.join(File.dirname(__FILE__), '..', '..', 'static'), 'mail')
            
        end      
      
        # Configure a before filter to initialize the session attribute mailbox with the user name of the connected user 
        # TODO No execute for static resources
        app.before do
   
          if user
	        session[:mailbox] = user['username'] unless session[:mailbox]   
            #puts "MailBox : #{session[:mailbox]} user: #{user['username']} path : #{request.path_info}" 
          else
            session.delete(:mailbox) if session[:mailbox]
            #puts "deleted mailbox from session (No user connected) #{request.path_info}"
          end
   
        end      
      
      end  
    
    end # Mail
  end # YSD
end # Sinatra