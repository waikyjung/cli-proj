require "minitest/autorun"
require "./blocksmashers"

class TestBlocksmashers < Minitest:: Test
  def test_add_title
    new_title = Rental.new
    assert_equal 5, new_title.add_title("DVD", "Batman Forever", 1997, 5, 0), "Title Add Method Failed"
  end
end
