ENV['RAILS_ENV'] ||= 'test'

$LOAD_PATH.unshift(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift(__dir__)

require 'active_record'
require 'wrong/adapters/rspec'
require 'arenai'
require 'fake_app'
require 'byebug'

ActiveRecord::Base.establish_connection('sqlite3::memory:')

RSpec.configure do |config|
  config.before :all do
    CreateAllTables.up unless ActiveRecord::Base.connection.table_exists? 'authors'

    matz = Author.create!(name: 'matz', email: 'matz@ruby-lang.org')
    keiju = Author.create!(name: 'keiju')
    Author.create! name: 'takahashim'
    Author.create! name: 'aamine'
    Author.create! name: 'nari'

    matz.books.create!(price: 5000)
    keiju.books.create!(price: 1000)
  end

#   config.order = 'random'
end
