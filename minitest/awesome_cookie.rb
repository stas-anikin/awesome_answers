require 'minitest/autorun'

class AwesomeCookie < Minitest::Test

    class Cookie
        attr_accessor :sugar, :butter
        SUGAR_CALORIES=4
        BUTTER_CALORIES=9
        def initialize(sugar,butter)
            @sugar = sugar
            @butter = butter
        end
        def colorie_count
            sugar* SUGAR_CALORIES + butter*BUTTER_CALORIES
        end

    end
    def test_cookie_has_method
        #given
        #  A cookie with 5g of sugar and 10g of butter
        c=Cookie.new(5,10)

        #when - Call sugar method on cookie object 
        result = c.sugar

        #then : I should ge t reuld as 5
        assert_equal(result,5)
    end

end
