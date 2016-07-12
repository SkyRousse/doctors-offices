require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('view all of the doctors offices in the db', {:type => :feature}) do
  it('shows the user the list of doctors offices in the database') do
    visit('/')
    doctors_office = DoctorsOffice.new({:id => nil, :name => 'DR Hollemans Practice', :specialty => 'general care'})
    doctors_office.save()
    visit('/')
    expect(page).to have_content(doctors_office.name())
  end
end
