require File.expand_path("spec_helper", File.dirname(__FILE__))

require_driver "stomp"

describe AMQ::Drivers::Stomp do

   let(:client) { AMQ::Client.new }
   let(:driver) { client.driver.client }

   before do
      AMQ.config.driver = :stomp

      AMQ.config.connection_settings = {
         :username => "mylogin",
         :password => "mypass",
         :host => "mq.local",
         :port => 101010,
         :reliable => true
      }

      client.driver.should_receive(:client_class).
                    any_number_of_times.
                    and_return { StompTestClient }
   end

   it "should use the configuration's connection settings on connect" do
      client.driver.connect

      driver.username.should == "mylogin"
      driver.password.should == "mypass"
      driver.hostname.should == "mq.local"
      driver.port.should == 101010
      driver.reliable.should == true
   end

   it "should call the subscribe method on the driver with the queue" do
      callback = Proc.new {}
      
      client.subscribe "foo", &callback

      driver.subscribers["/topic/foo"].length.should == 1
   end

   it "should publish data to the queue in JSON encoded format" do
      client.publish :foo, :bar => :baz

      driver.messages["/topic/foo"].length.should == 1

      msg, headers = driver.messages["/topic/foo"].first

      msg.should be_a_json_string_equal_to({"bar" => "baz"})

      headers.should == {:persistent => true}
   end

   it "should notify subscribers with parsed data" do
      datum = []

      client.subscribe(:foo) {|data| datum.push(data) }

      client.publish :foo
      client.publish :foo, :foo => :bar
      client.publish :bar, :blah => :blah
      client.publish :foo, :foo => :baz

      datum.should == [{}, {"foo" => "bar"}, {"foo" => "baz"}]
   end

end