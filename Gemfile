source 'https://rubygems.org'
ruby '1.9.3' # specify ruby version, needed by Heroku.

# hack to make heroku cedar not install special groups
def hg(g)
  (ENV['HOME'].gsub('/','') == 'app' ? 'test' : g)
end


gem 'rails', '3.2.8'

gem 'jquery-rails', '2.1.3'
gem         'haml', '3.1.6'
gem         'sass', '3.2.1'


gem 'bootstrap-sass', '2.1.0.0'
gem         'devise', '2.1.2'
gem         'cancan', '1.6.8'
gem         'rolify', '3.2.0'
gem    'simple_form', '2.0.3'
gem         'roboto', '0.1.0'
# gem 'google_visualr', '2.1.3'

gem 'jquery-datatables-rails', '1.11.1'
gem         'brazilian-rails', '3.3.0'

# Mailchimp and Mandrill integrations
gem 'hominid', '3.0.5'
gem 'mandrill', :git => 'git://github.com/cyu/mandrill.git', :ref => 'ff39daa93ea0c1240274527bac3ab983b45a3c38'

# Recommended for Heroku deployment
gem 'unicorn', '4.4.0'
gem      'pg', '0.14.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem   'sass-rails', '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem     'uglifier', '1.2.3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'guard-bundler'
  gem 'spork'
  gem 'rb-readline' # Required to solve Guard Interactor hanging
  gem 'factory_girl_rails'
  gem 'letter_opener'
end

group :test do
  gem 'launchy'
  gem 'capybara'
  gem 'email_spec'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end

group hg(:darwin) do
  gem 'capybara-webkit'
  gem 'rb-fsevent', :require => false
  gem 'terminal-notifier-guard' # Notifications on Mac OS X Mountain Lion Notification Center
  gem 'guard-pow' # Restarts pow server automatically after changes that require this
end

group hg(:linux) do
  gem 'minitest'
end

group :production do
  gem 'newrelic_rpm'
end
