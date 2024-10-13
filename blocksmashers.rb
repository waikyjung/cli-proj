require_relative "./bs_inventory"
class Rental
  attr_accessor :title, :year, :item_type, :stock
  def initialize(title, year, item_type, stock)
    @title = title
    @year = year
    @item_type = item_type
    @stock = stock
  end
end

class Blocksmashers
  def initialize
    @data = $starting_inventory
    @inventory = []
    @data.each { |item| @inventory.push Rental.new(*item) }
    self.sort_titles
  end

  def sort_titles
    @inventory.sort_by!(&:title)
    @inventory.sort_by!(&:item_type)
  end

  def display
    @inventory.each { |item| puts "#{num.next}. [#{item.item_type}] #{item.title} (#{item.year}) - Available: #{item.stock}" }
  end

  def add_title(title, year, item_type, stock)
    @inventory.push Rental.new(title, year, item_type, stock)
    self.sort_titles
  end

  def remove_title(title, year)
  end
end

x = Blocksmashers.new

x.display
