source 'https://rubygems.org'
ruby '1.9.3' # Specify ruby version, needed by Heroku.

# Hack to make heroku cedar not install special groups
def hg(g)
  (ENV['HOME'].gsub('/','') == 'app' ? 'test' : g)
end


gem 'rails', '3.2.9'

gem 'jquery-rails', '2.1.4'
gem         'haml', '3.1.7'
gem         'sass', '3.2.3'
gem   'haml-rails', '0.3.5'
gem    'rdiscount', '1.6.8'

gem 'bootstrap-sass', '2.2.1.1'
gem         'devise', '2.1.2'
gem         'cancan', '1.6.8'
gem         'rolify', '3.2.0'
gem    'simple_form', '2.0.4'
gem         'roboto', '0.1.0'

gem 'jquery-datatables-rails', '1.11.2'
gem         'brazilian-rails', '3.3.0'

# Mailchimp and Mandrill integrations
gem 'hominid', '3.0.5'
gem 'mandrill', :git => 'git://github.com/cyu/mandrill.git', :ref => 'ff39daa93ea0c1240274527bac3ab983b45a3c38'

# Recommended for Heroku deployment
gem 'unicorn', '4.5.0'
gem      'pg', '0.14.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem   'sass-rails', '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem     'uglifier', '1.3.0'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'guard-bundler'
  gem 'spork'
  gem 'factory_girl_rails'
  gem 'letter_opener'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'launchy'
  gem 'capybara'
  gem 'email_spec'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end

group hg(:darwin) do
  gem         'capybara-webkit', :require => false
  gem              'rb-fsevent', :require => false # File system events monitor for Mac OS X
  gem 'terminal-notifier-guard', :require => false # Notifications on Mac OS X Mountain Lion Notification Center
  gem               'guard-pow', :require => false # Restarts Pow server automatically after changes that require this
  gem                  'powder', :require => false # Syntatic sugar for Pow server
end

group hg(:linux) do
  gem 'minitest'
end

group :production do
  gem 'newrelic_rpm', '3.5.3.25'
end
