module AMQ
   class Client
      def driver
         @driver ||= AMQ.config.driver_class.new()
      end
   end
end