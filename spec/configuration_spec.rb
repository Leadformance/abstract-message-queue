require File.expand_path("spec_helper", File.dirname(__FILE__))

describe AMQ do
   it "should define configuration" do 
      AMQ.config.should be_an_instance_of AMQ::Configuration
   end

   it "should allow setting the driver" do
      AMQ.config.driver = :stomp
      AMQ.config.driver.should == :stomp
   end

   it "should raise an exception if a driver is undefined" do
      lambda do
         AMQ.config.driver = :foo
      end.should raise_error
   end

   it "should lazy load the class when accessed" do
      AMQ.config.driver_class.should == AMQ::Drivers::Stomp
   end

   it "should allow setting driver connection settings" do
      AMQ.config.connection_settings = {:foo => "bar"}
      AMQ.config.connection_settings.should == {:foo => "bar"}
   end
end