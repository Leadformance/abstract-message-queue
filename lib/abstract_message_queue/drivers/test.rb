
module AMQ end
module AMQ::Drivers end

class AMQ::Drivers::Test
   attr_accessor :queue
   attr_accessor :subscribers

   def initialize
      self.queue = []
      self.subscribers = {}
   end
   
   def connect
   end

   def publish(message, data={})
      queue.push [message, data]
      (subscribers[message] || []).each do |subscriber|
         subscriber.call(data)
      end
   end

   def subscribe(message, &block)
      subscribers[message] ||= []
      subscribers[message].push block
   end

end