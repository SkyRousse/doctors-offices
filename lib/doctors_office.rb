class DoctorsOffice
  attr_reader(:id, :name, :specialty)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
  end

  define_method(:==) do |another_doctors_office|
    self.id().==(another_doctors_office.id()).&(self.name().==(another_doctors_office.name())).&(self.specialty().==(another_doctors_office.specialty()))
  end

  define_singleton_method(:all) do
    returned_doctors_offices = DB.exec('SELECT * FROM doctors_offices ORDER BY name ASC;')
    doctors_offices = []
    returned_doctors_offices.each() do |doctors_office|
      id = doctors_office.fetch('id').to_i
      name = doctors_office.fetch('name')
      specialty = doctors_office.fetch('specialty')
      doctors_offices.push(DoctorsOffice.new({:id => id, :name => name, :specialty => specialty}))
    end
    doctors_offices
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors_offices (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:find) do |id|
    found_doctors_office = nil
    DoctorsOffice.all().each() do |doctors_office|
      if doctors_office.id().==(id)
        found_doctors_office = doctors_office
      end
    end
    found_doctors_office
  end

  define_method(:patients) do
    doctors_office_patients = []
    patients = DB.exec("SELECT * FROM patients WHERE doctors_office_id = #{self.id()}")
    patients.each() do |patient|
      doctors_office_id = patient.fetch('doctors_office_id').to_i
      name = patient.fetch('name')
      birthdate = patient.fetch('birthdate')
      doctors_office_patients.push(Patient.new({:doctors_office_id => doctors_office_id, :name => name, :birthdate => birthdate}))
    end
    doctors_office_patients
  end

end
