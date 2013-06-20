require 'rspec'
require 'date'
require_relative '../app/models/teacher'


describe Teacher, "#name" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:teachers).should be_true
    Teacher.delete_all

    @teacher = Teacher.new
    @teacher.assign_attributes(
      :first_name => "Kate",
      :last_name => "FromLost",
    )
  end

  it "should have name method" do
    [:name].each { |mthd| @teacher.should respond_to mthd }
  end

  it "should concatenate first and last name" do
    @teacher.name.should == "Kate FromLost"
  end
end

describe Teacher, "validations" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:teachers).should be_true
    Teacher.delete_all
  end

  before(:each) do
    @teacher = Teacher.new
    @teacher.assign_attributes(
      :first_name => "Kate",
      :last_name => "FromLost",
      :email => 'kateis@sohot.com',
      :phone => '(510) 333-1212 x4567'
    )
  end

  it "should accept valid info" do
    @teacher.should be_valid
  end

  it "shouldn't accept invalid emails" do
    ["XYZ!bitnet", "@.", "a@b.c"].each do |address|
      @teacher.assign_attributes(:email => address)
      @teacher.should_not be_valid
    end
  end

  it "should accept valid emails" do
    ["joe@example.com", "info@bbc.co.uk", "bugs@devbootcamp.com"].each do |address|
      @teacher.assign_attributes(:email => address)
      @teacher.should be_valid
    end
  end

  it "shouldn't allow two teachers with the same email" do
    another_teacher = Teacher.create!(
      :email => @teacher.email,
      :phone => @teacher.phone
    )
    @teacher.should_not be_valid
  end

end

describe Teacher, "advanced validations" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:teachers).should be_true
    Teacher.delete_all
  end

  before(:each) do
    @teacher = Teacher.new
    @teacher.assign_attributes(
      :first_name => "Kate",
      :last_name => "FromLost",
      :email => 'kateis@sohot.com',
      :phone => '(510) 333-1212 x4567'
    )
  end

  it "should accept valid info" do
    @teacher.should be_valid
  end

  it "shouldn't accept invalid phone numbers" do
    @teacher.assign_attributes(:phone => '347-8901')
    @teacher.should_not be_valid
  end
end
