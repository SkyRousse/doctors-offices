require('spec_helper')

describe(Patient) do
  describe('#doctors_office_id') do
    it('returns the doctors_office_id of the patient') do
      test_patient = Patient.new({:doctors_office_id => 1, :name => 'John', :birthdate => '1990-07-08'})
      expect(test_patient.doctors_office_id()).to(eq(1))
    end
  end

  describe('#name') do
    it('returns the name of the patient') do
      test_patient = Patient.new({:doctors_office_id => 1, :name => 'John', :birthdate => '1990-07-08'})
      expect(test_patient.name()).to(eq('John'))
    end
  end

  describe('#birthdate') do
    it('returns the birthdate of the patient') do
      test_patient = Patient.new({:doctors_office_id => 1, :name => 'John', :birthdate => '1990-07-08'})
      expect(test_patient.birthdate()).to(eq('1990-07-08'))
    end
  end

  describe('#==') do
    it('is the same patient if it has the same attributes') do
      patient1 = Patient.new({:doctors_office_id => 1, :name => "John", :birthdate => '1990-07-08'})
      patient2 = Patient.new({:doctors_office_id => 1, :name => "John", :birthdate => '1990-07-08'})
      expect(patient1).to(eq(patient2))
    end
  end

  describe('.all') do
    it("is empty at first") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds a patient to the array of saved patients') do
      patient1 = Patient.new({:doctors_office_id => 1, :name => "John", :birthdate => '1990-07-08'})
      patient1.save()
      expect(Patient.all()).to(eq([patient1]))
    end
  end

end
