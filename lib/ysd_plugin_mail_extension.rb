require 'ysd-plugins_viewlistener' unless defined?Plugins::ViewListener

#
# Social Mail Extension
#
module Huasi

  class MailExtension < Plugins::ViewListener
        
    # ---------------- Profile Hooks -------------------------    
        
    # --------------------------------------------------------------------
    # profile_not_owner_action
    # --------------------------------------------------------------------
    # Define an action in the profile page -> show a send message button
    # to a different profile
    # --------------------------------------------------------------------
    def profile_not_owner_action(context={})
       
       app = context[:app]
              
       app.render_profile_action_button(:text => "#{app.t.social_mail_action.send_message}", :link => "javascript:profileActionSendMessage.showMessageForm()" )
       
    end
    
    # --------------------------------------------------------------------
    # profile_not_owner_action_extension
    # --------------------------------------------------------------------
    # Defines necessary code to implement the profile_actions code
    # to a different profile∫
    # --------------------------------------------------------------------    
    def profile_not_owner_action_extension(context={})
     
      app = context[:app]
     
      the_script = <<"SCRIPT"
        
        <!-- Send a message (the block to send a message) -->
        <div id="send_message_form">
           <%= send_message_form %>
        </div>

        <script type="text/javascript">
           
           profileActionSendMessage = {
           	          	
           	  showMessageForm : function() { /* Show the message form */
             	               	             
  	             messageModel.setSender({'address': "<%=user['username']%>", 'name': "<%=user['full_name']%>"});
  	             messageModel.addReceiver({'address': "<%=@document['username']%>", 'name': "<%=@document['full_name']%>"});

  	             messageView.showForm();
  	               	             
  	          }
           	  
           };
                      
        </script>
SCRIPT

        if String.method_defined?(:encode)
          the_script.encode!('UTF-8')
        end
        
        app.erb the_script
    
    end
    
    # ---------------- Profile Hooks -------------------------
    
    # -------------------------------------------------
    # huasi_menu
    # -------------------------------------------------
    # Defines an option in the menu
    # -------------------------------------------------    
    def huasi_menu(context={})  
    
      app = context[:app]
    
      app.render_menu_option(:text => "#{app.t.social_menu.messages}", :link => "/mail/messages-reader")
    
    end
      
    # ========= Routes ===================
    
    # routes
    #
    # Define the module routes, that is the url that allow to access the funcionality defined in the module
    #
    #
    def routes(context={})
    
      routes = [{:path => '/mail/messages-reader',
                 :regular_expression => /^\/mail\/messages-reader/,
                 :title => 'Mail',
                 :description => 'The application which you can use to read, reply and send messages to other users',
                 :fit => 1,
                 :module => :mail}]
    
    end
      
  
  end #MailExtension
end #Social