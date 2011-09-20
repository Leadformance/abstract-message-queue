AMQ.config.driver = :stomp

# these are actually the defaults in case you dont define them
AMQ.config.connection_settings = {
   :username => '',
   :password => '',
   :host     => 'localhost',
   :port     => 61613,
   :reliable => false
}
