require 'active_support/inflector'

module AMQ
   class Configuration
      Drivers = {
         :stomp => "AMQ::Drivers::Stomp",
         :amazon_sqs => "AMQ::Drivers::SQS",
         :test => "AMQ::Drivers::Test"
      }

      attr_writer :connection_settings
      def connection_settings
         @connection_settings ||= {}
      end

      attr_reader :driver
      def driver=(driver)
         driver = driver.to_sym
         raise "undefined driver: #{driver}" unless Drivers.has_key?(driver)
         @driver = driver
      end

      def driver_class
         # lazy load the driver class
         require File.expand_path("drivers/#{driver}", File.dirname(__FILE__))

         # return the constantized version of the driver class
         Drivers[driver].constantize
      end

   end
end