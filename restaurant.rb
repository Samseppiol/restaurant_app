require 'terminal-table'

class MenuItem
  def initialize(name, price, description = 'Food')
    @name = name
    @price = price
    @description = description
  end

  attr_accessor :name, :price, :description
end

class Order
  def initialize()
    @items = []
  end

  def << (menu_item)
    @items << menu_item
  end

  def total
    total = 0
    @items.each do |item|
      total += item.price
    end
    "$#{total}"
  end

  def credit_card 
   total + total * 0.015
  end

  def bill
    table = Terminal::Table.new headings: ['Name', 'Price', 'Description'] do |t|
      @items.each do |item|
        t << [item.name, "$#{item.price}", "#{item.description}"]
      end
      t.add_separator
      t << ['TOTAL', total]
    end
    table
  end
end


  ITEMS = [
      MenuItem.new('Steak', 20, 'Medium Rare grain fed'),
      MenuItem.new('Parma', 15, 'Free range chicken'),
      MenuItem.new('Eggplant Casserole', 15, 'Tastes like rubbish'),
      MenuItem.new('Chips', 7, 'Deep fried with loads of salt'),
      MenuItem.new('Veggies', 28, 'Who would order this?'),
      MenuItem.new('Beer', 7, 'to wash the chips down'),
      MenuItem.new('Soft drink', 3.50, 'for the pansies who won`t drink beer'),
      MenuItem.new('Johnnie Walker', 9.50, 'smooth scotch'),
      MenuItem.new('Coronas', 8.50, 'Mexican Beer'),
      MenuItem.new('Greygoose', 11.50, 'vodka'),
      MenuItem.new('Gelati', 19, 'Italian Ice Cream'),
      MenuItem.new('Sticky Date Pudding', 13.50, 'delicious'),
      MenuItem.new('Vanilla Slice', 11.50, 'Custardy goodness'),
      MenuItem.new('Chocolate Pudding', 11.50, 'Rich'),
      MenuItem.new('Frozen Yoghurt', 11.50, 'Who would buy this')
    ]
  

  def prompt 
    puts "Hello and welcome to my dodgy restaurant, please give me the moneys!!!!"
    puts "What would you like to see?"
    puts "1. Food Menu"
    puts "2. Drinks Menu"
    puts "3. Desert Menu"
    puts "4. Everything"
    decision = gets.chomp.to_i
    ITEMS.each_with_index do |item, index|
      user_index = index + 1
      # Display item with index first, then name and price
      case decision 
      when 1
        puts "#{user_index}. #{item.name}: $#{item.price}, #{item.description}" if index < 5
      when 2
        puts "#{user_index}. #{item.name}: $#{item.price}, #{item.description}" if (index >= 5) && (index < 10)
      when 3 
        puts "#{user_index}. #{item.name}: $#{item.price}, #{item.description}" if index >= 10
      when 4
        puts "#{user_index}. #{item.name}: $#{item.price}, #{item.description}"
      end
    end
    lol_loop 
  end 

  def lol_loop
    order = Order.new
    loop do
      puts 'What would you like?'
      choice = gets.chomp

      # Stop looping if user pressed just enter
      break if choice == ""


      # User must choose an index number
      user_index = choice.to_i

      # If the user entered in an invalid choice
      if user_index == 0
        "Invalid choice, please try again"
        next # Loop through and ask again
      end

      puts "Any requests?"
      request = gets.chomp 
      puts "Great, so you want #{request}, not a problem"
        index = user_index - 1 # Convert to zero-based index
        menu_item = ITEMS[index]
        # Add item to order
        order << menu_item

          puts order.bill
        
    end
    puts "How would you like to pay the bill?"
    puts "1. Cash"
    puts "2. Credit Card"
    puts "3. Illegal Weapons"
    choice = gets.chomp.to_i
    if choice == 1
      puts "That will be #{order.total} thank you."
    elsif choice == 2 
      puts "We have a surchage of 1.5 %, that will be #{order.credit_card}"
    elsif choice == 3 
      puts " IM CALLING THE POLICE"
    end 

  end 

prompt

