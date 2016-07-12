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
