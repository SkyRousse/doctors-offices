require('rspec')
require('pg')
require('doctors_office')
require('patient')

DB = PG.connect({:dbname => 'doctors_office_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM doctors_offices *;")
    DB.exec("DELETE FROM patients *;")
  end
  config.after(:each) do
    DB.exec("DELETE FROM doctors_offices *;")
    DB.exec("DELETE FROM patients *;")
  end
end
