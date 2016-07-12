require('spec_helper')

describe(DoctorsOffice) do
  describe('.all') do
    it('starts off as an empty array') do
      expect(DoctorsOffice.all()).to(eq([]))
    end
  end

  describe('#name') do
    it('returns the doctors office name') do
      doctors_office = DoctorsOffice.new({:id => nil, :name => 'DR Hollemans Practice', :specialty => 'general care'})
      expect(doctors_office.name()).to(eq('DR Hollemans Practice'))
    end
  end

  describe('#specialty') do
    it('returns the doctors office specialty') do
      doctors_office = DoctorsOffice.new({:id => nil, :name => 'DR Hollemans Practice', :specialty => 'general care'})
      expect(doctors_office.specialty()).to(eq('general care'))
    end
  end

  describe('#==') do
    it('is the same doctors_office if it has the same attributes') do
      doctors_office1 = DoctorsOffice.new({:id => nil, :name => 'DR Hollemans Practice', :specialty => 'general care'})
      doctors_office2 = DoctorsOffice.new({:id => nil, :name => 'DR Hollemans Practice', :specialty => 'general care'})
      expect(doctors_office1).to(eq(doctors_office2))
    end
  end

  describe('#save') do
    it('lets you save the object to the database') do
      doctors_office = DoctorsOffice.new({:id => nil, :name => 'DR Hollemans Practice', :specialty => 'general care'})
      doctors_office.save()
      expect(DoctorsOffice.all()).to(eq([doctors_office]))
    end
  end

  describe('#id') do
    it('returns the doctors office id') do
      doctors_office = DoctorsOffice.new({:id => nil, :name => 'DR Hollemans Practice', :specialty => 'general care'})
      doctors_office.save()
      expect(doctors_office.id()).to(be_an_instance_of(Fixnum))
    end
  end

end
