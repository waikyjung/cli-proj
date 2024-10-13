require_relative "./bs_inventory"
class Rental
  attr_accessor :item_type, :title, :year, :available, :rented
  def initialize(item_type, title, year, available, rented)
    @item_type = item_type
    @title = title
    @year = year
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
  
  @@lines = "-" * 100
  @@stars = "*" * 30
  def welcome
    puts @@lines
    puts "Welcome to Blocksmashers Video!"
    puts @@lines
  end

  def options
    puts "(a) Rent Out Title (b) Return Title, (c) Add Title (d) Remove Title (e) Update Title (f) Exit" 
  end

  def continue
    puts "Press any key to continue..."
    gets  
  end

  def valid_option(num)
    return num.class == Integer && num >= 0 && num < @inventory.count ? true : false
  end

  def display
    self.sort_titles
    @num = 0
    @inventory.each do |item| 
      @num += 1
      puts "#{@num}) [#{item.item_type}] #{item.title} (#{item.year}) - Available: #{item.available} - Rented: #{item.rented}"
    end
  end

  def add(item_type, title, year, available, rented)
    @inventory.push Rental.new(item_type, title, year, available, rented = 0)
    self.sort_titles
  end

  def remove(num)
    @inventory.delete_at(num)
    self.sort_titles
  end

  def update(num)

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
      print "Enter Option: "
      select = gets.chomp
      case select.downcase
      when "a"
        print "Which title to rent out? Enter Number: "
        @num = gets.chomp.to_i - 1
        puts
        if self.valid_option(@num) == true
          puts self.rent(@num) == true ? "[#{@inventory[@num].item_type}] #{@inventory[@num].title} (#{@inventory[@num].year}) RENTED OUT." : "[#{@inventory[@num].item_type}] #{@inventory[@num].title} (#{@inventory[@num].year}) NOT AVAILABLE FOR RENT!"
        else
          puts "Invalid Option, Try Again!"
        end
        self.continue
      when "b"
        print "Which title to return? Enter Number: "
        @num = gets.chomp.to_i - 1
        puts
        if self.valid_option(@num)
          puts self.return(@num) == true ? "[#{@inventory[@num].item_type}] #{@inventory[@num].title} (#{@inventory[@num].year}) RETURNED." : "[#{@inventory[@num].item_type}] #{@inventory[@num].title} (#{@inventory[@num].year}) SHOULD NOT HAVE ANY COPIES RENTED OUT!"
        else
          puts "Invalid Option, Try Again!"
        end
        self.continue
      when "c"
        print "Enter Media Type ('DVD', 'VHS', 'Videogame'): "
        @item_type = gets.chomp.to_s
        @item_type = "n/a" if @item_type.length == 0

        print "Enter Media Title: "
        @title = gets.chomp.to_s

        print "Enter Media Year (optional): "
        @year = gets.chomp.to_i
        @year = "n/a" if @year == 0 || @year.class != Integer

        print "Enter Copies Available: "
        @available = gets.chomp.to_i

        if @title.length > 0 && @available > 0 && @available.class == Integer
          self.add(@item_type, @title, @year, @available, "")
          puts
          puts "[#{@item_type}] #{@title} (#{@year}) x #{@available} ADDED TO INVENTORY."
        else
          puts
          puts "Some data not entered correctly! Please check and try again!"
        end
        self.continue
      when "d"
        print "Which title to remove? Enter Number: "
        @num = gets.chomp.to_i - 1
        if self.valid_option(@num)
          @temp = [@inventory[@num].item_type, @inventory[@num].title, @inventory[@num].year]
          self.remove(@num)
          puts
          puts "[#{@temp[0]}] #{@temp[1]} (#{@temp[2]}) REMOVED."
        else
          puts "Invalid Option, Try Again!"
        end
        self.continue
      when "e"

      when "f"
        system("clear")
        puts "Goodbye!"
        break
      else
        puts
        puts "Invalid Option, Try Again!"
        self.continue
      end
    end
  end
end


x = Blocksmashers.new
#puts x.rent(0) == true ? "rented!" : "denied"
#puts x.return(0) == true ? "returned!" : "denied"
x.start
