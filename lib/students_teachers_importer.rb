require_relative '../app/models/studentteacher'
require_relative '../app/models/student'
require_relative '../app/models/teacher'


module StudentTeacherImporter

  def self.import
    Student.all.each do |student|
      student.teachers << Teacher.all.sample # Active record magic
      student.teachers << Teacher.all.sample # Active record magic
      student.save
    end
  end

  # #Use this to add a random number of teacher for each student
  # def teachers_adder
  #   teach = []
  #   1.upto(rand(1..6)) do 
  #     teach << Teacher.all.sample
  #   end
  #   teach
  # end

end
