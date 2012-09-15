class MailDataSystemAdapter

  #
  # Post a message in a mailbox
  #
  def post(message)
  
    mail = MailDataSystem::Mail.new message
    mail.post  
    
    mail # returns the message
  end

  #
  # Update a message
  #
  def update(mail_id, options)
  
    if options.length > 0
      mail = MailDataSystem::Mail.get(mail_id)
      mail.update(options) 
    end
    
  end
  
  #
  # Count the conversations in a mailbox and folder
  #
  def count_conversations(mailbox, folder = :in)
    MailDataSystem::MailBox.count_conversations(mailbox, folder)
  end  
  
  #
  # Retrieve messages from a mailbox
  #
  def get_messages(mailbox, from=0, quantity=20, folder = :in)
    MailDataSystem::MailBox.find_messages(mailbox, from, quantity, folder)
  end
  
  #
  # Retrieve a message
  #
  def get_message(conversation_id) 
    MailDataSystem::Conversation.find_last_message(conversation_id)
  end
  
  # 
  # Retrieve a conversation
  #
  def get_conversation(conversation_id)
  
    conversation = MailDataSystem::Conversation.get(conversation_id)
    conversation.mails.all
    return conversation
    
  end


end