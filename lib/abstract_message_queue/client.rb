module AMQ
   class Client
      def driver
         @driver ||= AMQ.config.driver_class.new
      end

      def publish(message, data={})
         @driver.connect
         @driver.publish(message, data)
      end

      def subscribe(message, &block)
         @driver.connect
         @driver.subscribe(message, &block)
      end
   end
end