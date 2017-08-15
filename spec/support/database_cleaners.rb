require 'database_cleaner'

shared_context "db_cleanup" do |ar_strategy = :truncation|
  before(:all) do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner[:active_record].strategy = ar_strategy
    DatabaseCleaner.clean_with(:truncation)
  end
  after(:all) { DatabaseCleaner.clean_with(:truncation) }
end

shared_context "db_scope" do
  before(:each) { DatabaseCleaner.start }
  after(:each) { DatabaseCleaner.clean }
end

shared_context "db_cleanup_each" do |ar_strategy = :truncation|
  before(:all) do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner[:active_record].strategy = ar_strategy
    DatabaseCleaner.clean_with(:truncation)
  end
  after(:all) { DatabaseCleaner.clean_with(:truncation) }
  before(:each) { DatabaseCleaner.start }
  after(:each) { DatabaseCleaner.clean }
end