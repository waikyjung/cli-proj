require_relative "./bs_inventory"
class Rental
  attr_accessor :title, :year, :item_type, :available, :rented
  def initialize(title, year, item_type, available, rented)
    @title = title
    @year = year
    @item_type = item_type
    @available = available
    @rented = rented
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
  
  @@lines = "-" * 50
  def welcome
    puts @@lines
    puts "            Welcome to Blocksmashers!"
    puts @@lines
  end

  def options
    puts "Enter: (a) Display Titles, (b) Rent Out Title (c) Return Title, (d) Add Title (e) Remove Title (f) Exit" 
  end

  def display
    self.sort_titles
    num = 0
    @inventory.each do |item| 
      num += 1
      puts "#{num}) [#{item.item_type}] #{item.title} (#{item.year}) - Available: #{item.available} - Rented: #{item.rented}"
    end
  end

  def add(title, year, item_type, available, rented)
    @inventory.push Rental.new(title, year, item_type, available, rented = 0)
    self.sort_titles
  end

  def remove(num)
    @inventory.delete_at(num)
    self.sort_titles
  end

  def rent(num)
    if @inventory[num].available > 0
      @inventory[num].available -= 1
      @inventory[num].rented += 1
      return true
    else
      return false
    end
  end

  def return(num)
    if @inventory[num].rented > 0
      @inventory[num].available += 1
      @inventory[num].rented -= 1
      return true
    else
      return false
    end
  end

  def start
    loop do
      system("clear")
      self.welcome
      self.display
      puts @@lines
      self.options
      puts @@lines
      select = gets.chomp
      if select.downcase == "f"
        puts "Goodbye!"
        break
      end
    end
  end
end


x = Blocksmashers.new
#puts x.rent(0) == true ? "rented!" : "denied"
#puts x.return(0) == true ? "returned!" : "denied"
x.start
