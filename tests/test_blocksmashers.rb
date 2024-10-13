require "minitest/autorun"
require "./blocksmashers"

class TestBlocksmashers < Minitest:: Test
  def test_add_title
    new_title = Rental.new("DVD", "Batman Forever", 1997, 5, 0)
    assert_equal "[DVD] Batman Forever (1997) - Available: 5 - Rented: 0", new_title.info, "Title Add Method Failed"
  end

  def test_add_title2
    new_title = Rental.new("BluRay", "Batman Begins", 2005, 10, 0)
    assert_equal "[BluRay] Batman Begins (2005) - Available: 10 - Rented: 0", new_title.info, "Title Add Method Failed"
  end
end
