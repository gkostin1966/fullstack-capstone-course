# Capstone Application
## [production](https://secure-sea-66964.herokuapp.com/)
## [staging](https://serene-bayou-42101.herokuapp.com/)
# Notes
```

config/application.rb
    config.generators do |g|
      g.test_framework :rspec,
                       model_specs: true,
                       routing_specs: true,
                       controller_specs: true,
                       helper_specs: false,
                       view_specs: false,
                       request_specs: true,
                       policy_specs: false,
                       feature_specs: true
    end
    
spec/support
	api_helper.rb
	city_ui_helper.rb
	database_cleaners.rb
    
spec/spec_helper.rb
	...
	require_relative 'support/database_cleaners'
	require_relative 'support/api_helper'
	...
	config.include Mongoid::Matchers, orm: :mongoid
	config.include ApiHelper, type: :request 
	...   
    
spec/rails_helper.rb    
	...
	require 'rspec/rails'
	# Add additional requires below this line. Rails is not loaded until this point!
	Rails.logger = Logger.new(STDOUT)
	Mongo::Logger.logger.level = ::Logger::DEBUG
	...
	# If you're not using ActiveRecord, or you'd prefer not to run each of your
	# examples within a transaction, remove the following line or assign false
	# instead of true.
	config.use_transactional_fixtures = false # using DatabaseCleaner
	...
    
spec/*/*_spec.rb

RSpec.describe <class>, type: <controller, model, etc>, my_metadata_key: :my_metadata_value do
  include_context 'db_cleanup_each'

	 
end

```
