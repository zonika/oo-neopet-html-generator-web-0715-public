require 'erb'
class User
  # attrs here
  attr_reader :name
  attr_accessor :neopoints, :items, :neopets

  PET_NAMES = ["Angel", "Baby", "Bailey", "Bandit", "Bella", "Buddy", "Charlie", "Chloe", "Coco", "Daisy", "Lily", "Lucy", "Maggie", "Max", "Molly", "Oliver", "Rocky", "Shadow", "Sophie", "Sunny", "Tiger"]

  def initialize(name)
    @name = name
    @neopoints = 2500
    @items = []
    @neopets = []
  end
  def select_pet_name
    num = rand(0...PET_NAMES.size)
    pet_name = PET_NAMES[num]
  end
  def make_file_name_for_index_page
    index = @name.downcase.gsub(" ","-")
  end
  def buy_item
    if @neopoints >= 150
      it = Item.new
      @items << it
      @neopoints -= 150
      "You have purchased a #{it.type}."
    else
      "Sorry, you do not have enough Neopoints."
    end
  end
  def find_item_by_type(t)
    ret = nil
    @items.each do |item|
      ret = item if item.type == t
    end
    ret
  end
  def buy_neopet
    if @neopoints >= 250
      newpet = Neopet.new(select_pet_name)
      @neopets << newpet
      @neopoints -= 250
      "You have purchased a #{newpet.species} named #{newpet.name}."
    else
      "Sorry, you do not have enough Neopoints."
    end
  end
  def find_neopet_by_name(n)
    ret = nil
    @neopets.each do |np|
      ret = np if np.name == n
    end
    ret
  end
  def sell_neopet_by_name(n)
    sellpet = find_neopet_by_name(n)
    if sellpet == nil
      "Sorry, there are no pets named #{n}."
    else
      @neopoints += 200
      @neopets.delete(sellpet)
      "You have sold #{n}. You now have #{@neopoints} neopoints."
    end
  end
  def feed_neopet_by_name(n)
    pet = find_neopet_by_name(n)
    moo = pet.happiness
    if moo > 9
      "Sorry, feeding was unsuccessful as #{n} is already ecstatic."
    elsif moo == 9
      pet.happiness += 1
      "After feeding, #{n} is #{pet.mood}."
    else
      pet.happiness += 2
      "After feeding, #{n} is #{pet.mood}."
    end
  end
  def give_present(i,n)
    item = find_item_by_type(i)
    pet = find_neopet_by_name(n)
    if item == nil || pet == nil
      "Sorry, an error occurred. Please double check the item type and neopet name."
    else
      @items.delete(item)
      pet.items << item
      pet.happiness += 5
      if pet.happiness > 10
        pet.happiness = 10
      end
      "You have given a #{item.type} to #{pet.name}, who is now #{pet.mood}."
    end
  end
  def make_index_page
    template = File.read('./lib/models/user.html.erb')
    erb = ERB.new(template)
    File.open("./views/users/#{make_file_name_for_index_page}.html", "w+") { |file| file.puts erb.result(binding)}
  end
end
