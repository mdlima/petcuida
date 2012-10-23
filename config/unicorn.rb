worker_processes 3
timeout 30
preload_app true

# hack: traps the TERM signal, preventing unicorn from receiving it and performing its quick shutdown.
# My signal handler then sends QUIT signal back to itself to trigger the unicorn graceful shutdown
# http://stackoverflow.com/a/9996949/235297
before_fork do |_server, _worker|
  Signal.trap 'TERM' do
    puts 'intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end
end

# before_fork do |server, worker|
#   # Replace with MongoDB or whatever
#   if defined?(ActiveRecord::Base)
#     ActiveRecord::Base.connection.disconnect!
#     Rails.logger.info('Disconnected from ActiveRecord')
#   end
# 
#   # If you are using Redis but not Resque, change this
#   # if defined?(Resque)
#   #   Resque.redis.quit
#   #   Rails.logger.info('Disconnected from Redis')
#   # end
# 
#   sleep 1
# end

# Fix PostgreSQL SSL error
# http://stackoverflow.com/a/8513432/235297
after_fork do |server, worker|
  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end

  # If you are using Redis but not Resque, change this
  # if defined?(Resque)
  #   Resque.redis = ENV['REDIS_URI']
  #   Rails.logger.info('Connected to Redis')
  # end
end