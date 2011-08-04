require File.expand_path('../lib/abstract_message_queue', File.dirname(__FILE__))

def require_driver(name)
   require File.expand_path("../lib/abstract_message_queue/drivers/#{name}", File.dirname(__FILE__))
end