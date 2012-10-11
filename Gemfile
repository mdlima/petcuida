source 'https://rubygems.org'
ruby '1.9.3' # specify ruby version, needed by Heroku.

gem 'rails', '3.2.8'

gem 'jquery-rails', '2.1.3'
gem         'haml', '3.1.6'
gem         'sass', '3.2.1'


gem 'bootstrap-sass', '2.1.0.0'
gem        'hominid', '3.0.5'
gem         'devise', '2.1.2'
gem         'cancan', '1.6.8'
gem         'rolify', '3.2.0'
gem    'simple_form', '2.0.3'
gem 'google_visualr', '2.1.3'

gem 'jquery-datatables-rails', '1.11.1'

# Recommended for Heroku deployment
gem 'thin'
gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem   'sass-rails', '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem     'uglifier', '1.2.3'
end

group :development, :test do
  # gem     'sqlite3', '1.3.6'
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec', '1.2.1'
  gem 'guard-spork', '1.2.0'
  gem       'spork', '0.9.2'

  gem 'factory_girl_rails', '4.1.0'
  gem      'letter_opener', '1.0.0'
end

group :test do
  gem 'rb-fsevent', '0.9.1', :require => false
  # gem 'growl', '1.0.3' # Replaced by terminal-notifier-guard
  gem 'terminal-notifier-guard', '1.5.3' # Notifications on Mac OS X Mountain Lion Notification Center

  gem          'launchy', '2.1.2'
  gem         'capybara', '1.1.2'
  gem       'email_spec', '1.2.1'
  gem   'cucumber-rails', '1.3.0', :require => false
  gem 'database_cleaner', '0.8.0'
end
