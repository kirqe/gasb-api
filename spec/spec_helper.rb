ENV['RACK_ENV'] = 'test'

require './config/environment'
require 'database_cleaner'

RSpec.configure do |config|
  config.before(:each) do
    $redis.flushall
  end 
end


DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:all) do
    DatabaseCleaner.clean
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end  
end
