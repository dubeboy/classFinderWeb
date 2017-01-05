source 'https://rubygems.org'


gem 'rails'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'                        #FIXME REMOVE THIS ON WINDOWS
gem 'coffee-rails', '~> 4.1.0'                  #FIXME REMOVE THIS ON WINDOWS
 gem 'bcrypt-ruby', :require => "bcrypt"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'will_paginate'

#todo investigate this has_password thing
# Use ActiveModel has_secure_password
#gem 'bcrypt'


group :development do
  gem 'web-console', '~> 2.0'
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

group :development do
  gem 'puma-heroku'
end

group :production do
  gem 'pg'
end 

