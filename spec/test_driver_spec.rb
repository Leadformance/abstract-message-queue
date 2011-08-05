require File.expand_path("spec_helper", File.dirname(__FILE__))

require_driver "test"

describe AMQ::Drivers::Test do
   let(:driver) { AMQ::Drivers::Test.new }

   it "should publish a message onto its memory queue" do
      lambda do
         driver.publish :foo
      end.should change(driver.queue, :length).by(1)

      driver.queue.last.should == [:foo, {}]
   end

   it "should add subscribed procs to the subscription table" do
      driver.subscribers[:foo].should be_nil

      callback = Proc.new {}
      driver.subscribe(:foo, &callback)

      driver.subscribers[:foo].should == [callback]
   end

   it "should yield to the callback block each message and associated data that block is subscribed to" do
      datum = []

      driver.subscribe(:foo) {|data| datum.push(data) }

      driver.publish :foo
      driver.publish :foo, :foo => :bar
      driver.publish :bar, :blah => :blah
      driver.publish :foo, :foo => :baz

      datum.should == [{}, {:foo => :bar}, {:foo => :baz}]
   end

end