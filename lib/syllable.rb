class Syllable
  attr_accessor :unit
  attr_accessor :rank
  attr_accessor :stressed
  
  def initialize(unit, rank)
    @unit = unit
    @rank = rank
  end

end
