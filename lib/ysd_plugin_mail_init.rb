require 'ysd-plugins' unless defined?Plugins::Plugin
require 'sinatra/ysd_plugin_mail_middleware'
require 'ysd_plugin_mail_extension'

Plugins::SinatraAppPlugin.register :mail do

   name=        'mail'
   author=      'yurak sisa'
   description= 'Integrate the mail application'
   version=     '0.1'
   sinatra_helper Sinatra::MailHelpers
   sinatra_extension Sinatra::YSD::Mail
   sinatra_extension Sinatra::YSD::MailRESTApi 
   hooker            Huasi::MailExtension
  
end