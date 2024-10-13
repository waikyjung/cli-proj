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
    @inventory = inventory
  end
  def display
    #@inventory.count do |title| { |title, year, item_type, stock | pp "#{title}"}
  end
end
