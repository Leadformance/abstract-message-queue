require File.expand_path("spec_helper", File.dirname(__FILE__))

describe AMQ::Client do
   let(:client) { AMQ::Client.new }

   before do
      AMQ.config.driver = :test
   end

   it "should provide the driver instance" do
      client.driver.should be_an_instance_of AMQ::Drivers::Test
   end

end