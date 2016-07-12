require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require('./lib/doctors_office')
require("./lib/patient")
require("pg")

DB = PG.connect({:dbname => "doctors_office_test"})

get('/') do
  @doctors_offices = DoctorsOffice.all()
  erb(:index)
end

get('/doctors_office/new') do
  erb(:doctors_office_form)
end

post('/doctors_offices') do
  name = params.fetch("name")
  specialty = params.fetch("specialty")
  doctors_office = DoctorsOffice.new({:id => nil, :name => name, :specialty => specialty})
  doctors_office.save()
  @doctors_offices = DoctorsOffice.all()
  erb(:index)
end

get('/doctors_offices/:id') do
  @doctors_office = DoctorsOffice.find(params.fetch('id').to_i())
  erb(:doctors_office)
end

post('/patients') do
  doctors_office_id = params.fetch('doctors_office_id').to_i()
  name = params.fetch('name')
  birthdate = params.fetch('birthdate')
  @doctors_office = DoctorsOffice.find(doctors_office_id)
  @patient = Patient.new({:doctors_office_id => doctors_office_id, :name => name, :birthdate => birthdate})
  @patient.save()
  erb(:doctors_office)
end
