require 'stomp'
require 'json'

module AMQ end
module AMQ::Drivers end

class AMQ::Drivers::Stomp
   attr_reader :client

   def connect
      @client ||= build_client
   end

   def publish(message, data={})
      @client.publish("/queue/#{message}", data.to_json, :persistent => true)
   end

   def subscribe(message, &block)
      @client.subscribe("/queue/#{message}") do |message|
         begin
            block.call(JSON.parse message.body)
         rescue e
            # todo, log this or something?
         end
      end
   end

private
   def build_client
      config = AMQ.config.connection_settings

      username = config.fetch(:username, '')
      password = config.fetch(:password, '')
      hostname = config.fetch(:host,     'localhost')
      port     = config.fetch(:port,     61613)
      reliable = config.fetch(:reliable, false)

      client_class.new(username, password, hostname, port, reliable)
   end

   # we use this method so we can stub it out for testing
   def client_class
      Stomp::Client
   end
end