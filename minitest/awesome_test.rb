require 'minitest/autorun'
# must require 'minitest/autorun'

class AwesomeTest < Minitest::Test
    # The name od the test should begin wiht 'test_'
    # to run the test we will goto minitest dir and the $> ruby <filename> 
    # def test_something
    #     assert_equal(2, 1+1)
    # end
    class Vector
        attr_accessor :x,:y,:z
        def initialize(x,y,z)
            @x=x
            @y=y
            @z=z
        end
        def magnitude
            (x**2 + y**2 + z**2) ** (1.0 /2.0)
        end
        def plus(vector)
            Vector.new(x + vector.x, y + vector.y , z + vector.z)
        end
        def minus(vector)
            Vector.new(x - vector.x, y - vector.y , z - vector.z)
        end
    end
# This is a test suite for Vector class
describe Vector do
    # describe is a method provided by minitest to organize our tests
    describe '.magnitude' do
    # it() method is also provided by minitest for origanizing tests  
    it 'calculates and return the magnitude(length) of the vector' do
        #Given
        # Given is a new instance of a vector. This is a initial state before test
        vector=Vector.new(3,7,4)

        #When
        # The scenario or the method you want to test in this case it is .magnitude
        length=vector.magnitude

        # Then
        # The state of program after the behaviour

        # _ is a method in minitest. Pass it the value to assert.
        _(length).must_equal(8.602325267042627)

    end
    end
    describe '.pluss' do
        it ' return and instance of a vector' do
            # Given
            # Instance of two vectors
            vector_1=Vector.new(3,7,4)
            vector_2=Vector.new(3,7,4)

            #when
            added_vector=vector_1.plus(vector_2)

            #Then
            _(added_vector).must_be_kind_of(Vector)

        end
        it 'calculatest the correct vector' do
            # Given
            # Instance of two vectors
            vector_1=Vector.new(3,7,4)
            vector_2=Vector.new(3,7,4)
            #when
            added_vector=vector_1.plus(vector_2)

            #Then
            _(added_vector.x).must_equal(6)
            _(added_vector.y).must_equal(14)
            _(added_vector.z).must_equal(8)

        end
    end

end
end
