require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require('./lib/doctors_office')
require("./lib/patient")
require("pg")

DB = PG.connect({:dbname => "doctors_office"})

get('/') do
  @doctors_offices = DoctorsOffice.all()
  erb(:index)
end
