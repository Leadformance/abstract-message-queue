LIB = File.expand_path("abstract_message_queue", File.dirname(__FILE__))

require "#{LIB}/configuration"
require "#{LIB}/client"

module AMQ

   def self.config
      @@config ||= Configuration.new
   end

end
