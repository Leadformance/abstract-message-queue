require 'rubygems'
require 'abstract_message_queue'
require 'config'

client = AMQ::Client.new

client.publish :queue_name
client.publish :queue_name, :hello => :world
client.publish :some_other_queue, :something => :not_so_interesting
client.publish :queue_name, :event => :point_of_sale_update, :id => 37833
