require 'uri'
module Sinatra
  module YSD
    #
    # REST API for Mail
    #
    module MailRESTApi
   
      def self.registered(app)
      
        #
        # Configuration
        #
        app.set :mail_adapter, MailDataSystemAdapter.new
        app.set :mail_page_size, 10
             
        #
        # Post a new or reply message 
        #
        app.post "/mail/message" do
     
          request.body.rewind
          message = JSON.parse(URI.unescape(request.body.read))
              
          saved_message = settings.mail_adapter.post(message)
       
          content_type :json
          saved_message.to_json
       
        end
   
        #
        # Update a message
        #
        app.put "/mail/message/:id/mark_as_read" do
                        
          message = settings.mail_adapter.update(params[:id], {:read => true})
                
          content_type :json
          message.to_json
        
        end     
                    
        # Retrieve the messages (JSON) 
        #
        ["/mail/messages", 
         "/mail/messages/:mailbox/:folder/page/:page_num", 
         "/mail/messages/:folder/page/:page_num", 
         "/mail/messages/:folder/:conversation_id"].each do |path|
     
          app.get path do

            data = []

            mailbox = params[:mailbox] || session[:mailbox]

            #puts "Retrieving messages. Path : #{path} ** mailbox : #{mailbox} ** #{session[:mailbox]}"

            unless params[:conversation_id]
              page_num  = [params[:page_num].to_i, 1].max
              page_size = settings.mail_page_size
              data = settings.mail_adapter.get_messages(mailbox, (page_num - 1)*page_size, page_num*page_size)
            else
              data = settings.mail_adapter.get_message(params[:conversation_id]) 
              mailbox = data.first.mailbox.address if data.first
            end
              
            total = settings.mail_adapter.count_conversations(mailbox, params[:folder])      
              
            content_type :json
            { :data => data, :summary => {:total => total} }.to_json
            
          end
     
        end

        # Retrieve conversation messages
        #
        app.get "/mail/conversation/:id" do
   
          conversation = settings.mail_adapter.get_conversation(params[:id])
      
          result = { :conversation => conversation, :messages => conversation.mails.all, :total => conversation.mails.count }
       
          content_type :json
          result.to_json
   
        end
      
      end  
    
    end # MailRESTApi
  end # YSD
end # Sinatra