require_relative '../../db/config'

class Student < ActiveRecord::Base

  validates :email, :presence => true, :uniqueness => true, :format => { :with => /^.+@.+\..{2,5}$/ , :message => 'Invalid email, bitch'}
  validates :birthday, :presence => true
  validates :age, :numericality => {:greater_than => 5}
  validates :phone, :presence => true, :format => { :with => /\(\d{3}\).?\d{3}.?\d{4}/ , :message => 'Enter valid phone number'}



  def name
    first_name + " " + last_name
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def age_greater_than_5
   age > 5
  end

end
