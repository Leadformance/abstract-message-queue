require File.expand_path("spec_helper", File.dirname(__FILE__))

describe "Integration Testing" do
  let(:client) { AMQ::Client.new }
  before do
    AMQ.config.driver = :stomp
  end

  it "should have the appropriate driver instance" do
    client.driver.should be_an_instance_of AMQ::Drivers::Stomp
  end

  it "should post and receive" do
    lambda do
      client.subscribe(:foo) { |data| raise data.inspect }
      client.publish(:foo)
    end.should raise_error
  end

end
