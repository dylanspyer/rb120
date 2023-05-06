class Transform
  attr_reader :data

  def self.lowercase(str)
    str.to_s.downcase
  end

  def initialize(data)
    @data = data
  end

  def uppercase
    data.to_s.upcase
  end

end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')