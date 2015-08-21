require 'pry'
class Item
  attr_reader :type
  def initialize
    @type = get_type
  end
  def get_type
    types = Dir["./public/img/items/*.jpg"]
    ty = types.map { |t| t.gsub('./public/img/items/','') }
    num = rand(0...ty.size)
    @type = ty[num].gsub('.jpg','')
  end
  def format_type
    t = type.split('_')
    ty = t.map do |tt|
      tt.capitalize
    end
    ty.join(" ")
  end
end
