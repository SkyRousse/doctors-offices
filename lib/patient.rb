class Patient
  attr_reader(:doctors_office_id, :name, :birthdate)

  define_method(:initialize) do |attributes|
    @doctors_office_id = attributes.fetch(:doctors_office_id)
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
  end

  define_method(:==) do |another_patient|
    self.doctors_office_id().==(another_patient.doctors_office_id()).&(self.name().==(another_patient.name())).&(self.birthdate().==(another_patient.birthdate()))
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec("SELECT * FROM patients ORDER BY name ASC;")
    patients = []
    returned_patients.each() do |patient|
      doctors_office_id = patient.fetch("doctors_office_id").to_i()
      name = patient.fetch("name")
      birthdate = patient.fetch("birthdate")
      patients.push(Patient.new({:doctors_office_id => doctors_office_id, :name => name, :birthdate => birthdate}))
    end
    patients
  end

  define_method(:save) do
    DB.exec("INSERT INTO patients (doctors_office_id,name,birthdate) VALUES (#{@doctors_office_id}, '#{@name}', '#{@birthdate}');")
  end
end
