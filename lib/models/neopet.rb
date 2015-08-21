class Neopet
  attr_reader :name, :strength, :defence, :movement, :species
  attr_accessor :happiness, :items
  def initialize(name)
    @name = name
    @strength = get_points
    @defence = get_points
    @movement = get_points
    @happiness = get_points
    @species = get_species
    @items = []
  end

  def get_points
    rand(1..10)
  end

  def get_species
    types = Dir["./public/img/neopets/*.jpg"]
    ty = types.map { |t| t.gsub('./public/img/neopets/','') }
    num = rand(0...ty.size)
    @type = ty[num].gsub('.jpg','')
  end

  def mood
    if @happiness < 3
      "depressed"
    elsif @happiness < 5
      "sad"
    elsif @happiness < 7
      "meh"
    elsif @happiness < 9
      "happy"
    elsif @happiness < 11
      "ecstatic"
    end
  end
end
