require "minitest/autorun"

class Student
attr_accessor :first_name
attr_accessor :last_name
attr_accessor :score
def initialize(first_name, last_name, score)
    @first_name=first_name
    @last_name=last_name
    @score=score
end

def full_name
    "#{@first_name} #{last_name}"
end
def grade
    if @score > 90 then
        return 'A'
    elsif @score > 30 && @score <= 90
        return 'B'
    else
        return 'F'
    end
end
describe "Student" do
    it 'when initialized with correct arguments' do
        first_name='Jon'
        last_name='Bond'
        score=79
        expect(Student.new(first_name,last_name,score)).must_be_kind_of(Student)
      end
    it 'retruns the concatenated string of first_name and last name' do
    # Given
    first_name='Jon'
    last_name='Bond'
    score=79
    std=Student.new(first_name,last_name,score)

    # When
    full_name=std.full_name

    # Then 
    _(full_name).must_equal("#{first_name} #{last_name}")
    end
    it 'returns A at score 95' do
    # Given
    first_name='Jon'
    last_name='Bond'
    score=95
    std=Student.new(first_name,last_name,score)

    gradeA= std.grade
    _(gradeA).must_equal('A')
    end
    it 'returns F at score 30' do
        # Given
        first_name='Jon'
        last_name='Bond'
        score=30
        std=Student.new(first_name,last_name,score)

        gradeA= std.grade
        _(gradeA).must_equal('F')
        end

end

end 