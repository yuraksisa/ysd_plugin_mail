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
    def profile_not_owner_action(context={}, element)
       
       app = context[:app]                     
       app.render_profile_action_button(:data_icon => '&#xe073;', 
          :class => 'mini-button', 
          :text => "#{app.t.social_mail_action.send_message}", 
          :link => "javascript:profileActionSendMessage.showMessageForm()" )
    end
    
    # --------------------------------------------------------------------
    # profile_not_owner_action_extension
    # --------------------------------------------------------------------
    # Defines necessary code to implement the profile_actions code
    # to a different profile∫
    # --------------------------------------------------------------------    
    def profile_not_owner_action_extension(context={}, element)
     
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
  	             messageModel.addReceiver({'address': "<%=element['username']%>", 'name': "<%=element['full_name']%>"});

  	             messageView.showForm();
  	               	             
  	          }
           	  
           };
                      
        </script>
SCRIPT

     template = Tilt['erb'].new { the_script }
     template.render(app,{:element => element})
     
    end
    
    # ========= Resource declaration ============
    
    #
    # It retrieves the images declared in the module
    #
    def resource_images(context={})
      ['/mail/img/Mail.png']
    end    
    
    # ========= Page Building ============
    
    #
    # It gets the style sheets defined in the module
    #
    # @param [Context]
    #
    # @return [Array]
    #   An array which contains the css resources used by the module
    #
    #def page_style(context={})
    #  ['/mail/css/mail.css']     
    #end
          
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