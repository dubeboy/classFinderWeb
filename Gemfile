source 'https://rubygems.org'


gem 'rails'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'                        #FIXME REMOVE THIS ON WINDOWS
gem 'coffee-rails', '~> 4.1.0'                  #FIXME REMOVE THIS ON WINDOWS
 gem 'bcrypt-ruby', :require => "bcrypt"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'rake'
gem 'turbolinks'
gem 'active_model_serializers', '~> 0.10.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'will_paginate'
# TODO NEED  TO RUN THE PART WHERE WE ACTUALLY MAP THE ID THING TO THE NICE URL , involves DB, so scary https://2017doneright.com/comprehensive-guide-on-seo-in-rails-8b124ca81d37#.dkh300u3b
gem 'friendly_id'
gem 'delayed_job_active_record'

#todo investigate this has_password thing
# Use ActiveModel has_secure_password
#gem 'bcrypt'


group :development do
  gem 'web-console', '~> 2.0'
  # gem 'ruby-debug-ide', '~> 0.6.0'
  gem 'faker'
  gem 'spring' #this gem cost me the whole day ' talikung about unmet depencies while bundler was satified'
  gem 'byebug'
  source 'https://rails-assets.org' do
    gem 'rails-assets-bootstrap'
    gem 'rails-assets-bootstrap-material-design'
  end
  
  gem 'sqlite3'
end

# gem 'paperclip'
gem 'paperclip', '4.2.0'
gem 'aws-sdk', '< 2'
gem 'puma'
gem 'omniauth-google-oauth2', '~> 0.2.1'
gem 'jquery-ui-rails'
gem 'font-awesome-rails'
#Sending SMS
gem 'twilio-ruby'

gem 'swagger-docs'
gem 'stripe'
# gem 'redis', '~> 3.0'
gem 'fcm'

group :development do
  gem 'puma-heroku'
end

group :production do
 #gem 'pg'
end 

