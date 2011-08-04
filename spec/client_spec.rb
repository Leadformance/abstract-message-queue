require File.expand_path("spec_helper", File.dirname(__FILE__))

describe AMQ::Client do
   let(:client) { AMQ::Client.new }

   before do
      AMQ.config.driver = :test
   end

   it "should provide the driver instance" do
      client.driver.should be_an_instance_of AMQ::Drivers::Test
   end

   it "should call connect each time a pub/sub method is called" do
      client.driver.should_receive(:connect).exactly(3).times

      client.publish(:foo)
      client.publish(:foo)
      client.subscribe(:foo) {|message| puts message }
   end

   it "should delegate the publish arguments to the driver" do
      client.driver.should_receive(:publish).with(:foo, {:bar => :baz})
      client.publish(:foo, :bar => :baz)
   end

   it "should delegate the subscribe arguments to the driver" do
      callback = Proc.new {}

      client.driver.should_receive(:subscribe).with(:foo, &callback)

      client.subscribe(:foo, &callback)
   end

end