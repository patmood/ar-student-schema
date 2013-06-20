require_relative '../../db/config'

class Teacher < ActiveRecord::Base
  has_many :students, :through => :student_teachers
  has_many :student_teachers, :foreign_key => :teacher_id

  validates :email, :presence => true, :uniqueness => true, :format => { :with => /^.+@.+\..{2,5}$/ , :message => 'Invalid email, bitch'}
  validates :phone, :presence => true, :format => { :with => /\(?\d{3}\)?.?\d{3}.?\d{4}\s*[x]?\d{4}?/ , :message => 'Enter valid phone number'}

  def name
    first_name + " " + last_name
  end
end
