require File.expand_path('../lib/abstract_message_queue', File.dirname(__FILE__))
require 'json'

def require_driver(name)
   require File.expand_path("../lib/abstract_message_queue/drivers/#{name}", File.dirname(__FILE__))
end

RSpec::Matchers.define :be_a_json_string_equal_to do |expected|
   match do |actual|
      JSON.parse(actual) rescue {} == expected
   end
end

# this is a mocked class that implements the same protocol as Stomp::Client
# but does not actually do anything
class StompTestClient
   class Message < Struct.new(:body)
   end

   attr_reader :username, :password, :hostname, :port, :reliable
   attr_reader :messages, :subscribers

   def initialize(username='', password='', hostname='localhost', port=61613, reliable=false)
      @username = username
      @password = password
      @hostname = hostname
      @port     = port
      @reliable = reliable

      @messages = {}
      @subscribers = {}
   end

   def subscribe(destination, headers={}, &block)
      @subscribers[destination] ||= []
      @subscribers[destination].push [headers, block]
   end

   def publish(destination, message, headers={})
      @messages[destination] ||= []
      @messages[destination].push [message, headers]

      (@subscribers[destination] || []).each do |headers, block|
         block.call(Message.new(message))
      end
   end
end