require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('view doctor office path', {:type => :feature}) do
  it('shows the user the list of doctors offices in the database') do
    visit('/')
    expect(page).to have_content('There are no doctors offices yet; Add one below.')
    doctors_office = DoctorsOffice.new({:id => nil, :name => 'DR Hollemans Practice', :specialty => 'general care'})
    doctors_office.save()
    visit('/')
    expect(page).to have_content(doctors_office.name())
  end
end

describe('add office path', {:type => :feature}) do
  it('allows user to add a new office') do
    visit('/')
    click_link('Add New Office')
    expect(page).to have_content("Add a Doctor Office")
    fill_in('name', :with => 'Kim Practice')
    fill_in('specialty', :with => 'Knee Surgery')
    click_button('Add Doctor Office')
    expect(page).to have_content("Kim Practice Knee Surgery")
  end
end

describe('view patient path', {:type => :feature}) do
  it('shows the user the list of patients for a given doctor office in the database') do
    doctors_office = DoctorsOffice.new({:id => nil, :name => 'DR Hollemans Practice', :specialty => 'general care'})
    doctors_office.save()
    visit("/doctors_offices/#{doctors_office.id()}")
    expect(page).to have_content('DR Hollemans Practice')
    patient = Patient.new({:doctors_office_id => doctors_office.id(), :name => 'John', :birthdate => '1990-07-08'})
    patient.save()
    visit("/doctors_offices/#{doctors_office.id()}")
    expect(page).to have_content('John 1990-07-08')
  end
end

describe('add patient path', {:type => :feature}) do
  it('allows user to add a new patient') do
    doctors_office = DoctorsOffice.new({:id => nil, :name => 'DR Hollemans Practice', :specialty => 'general care'})
    doctors_office.save()
    visit("/doctors_offices/#{doctors_office.id()}")
    fill_in('name', :with => 'Kim')
    fill_in('birthdate', :with => '2001-02-02')
    click_button('Add Patient')
    expect(page).to have_content("Kim 2001-02-02")
  end
end
