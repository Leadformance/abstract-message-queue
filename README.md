# What is this

This is a Leadformance gem to handle talking to our message queue server from
Ruby.  It handles serializing and deserializing data for us.

# What servers does it support?

Any server that supports the "stomp" protocol such as ActiveMQ, RabbitMQ, OpenMQ and many others

# How do I use it?

make the following files and then run subscriber.rb and publisher.rb,
be sure the install the gem first.

config.rb

```ruby
AMQ.config.driver = :stomp

# these are actually the defaults in case you dont define them
AMQ.config.connection_settings = {
   :username => '',
   :password => '',
   :host     => 'localhost',
   :port     => 61613,
   :reliable => false
}
```

subscriber.rb

```ruby
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
```

publisher.rb

```ruby
require 'rubygems'
require 'abstract_message_queue'
require 'config'

client = AMQ::Client.new

client.publish :queue_name
client.publish :queue_name, :hello => :world
client.publish :some_other_queue, :something => :not_so_interesting
client.publish :queue_name, :event => :point_of_sale_update, :id => 37833
```

# Any current bugs?

None apparent, it's only been tested with ActiveMQ so others i'm not as certain about.

# Future work?

Adding Amazon SQS support (need an account for this)