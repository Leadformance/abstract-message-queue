require 'rubygems'
require 'abstract_message_queue'
require 'config'

client = AMQ::Client.new

client.subscribe :queue_name do |data|
   puts "received a message from my queue with the following data: #{data.inspect}"
end

begin
  puts "Press ctrl+c when you're done"
  loop {}
rescue Interrupt => e
   puts "exiting..."
end
