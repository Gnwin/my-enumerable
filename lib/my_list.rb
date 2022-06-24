require_relative 'enumerable'

class MyList
  include Enumerable

  def initialize(*list)
    @list = list
  end

  def my_each
    if block_given?
      @list.length.times do |idx|
        yield(@list[idx])
      end
      @list
    else
      to_enum(__method__)
    end
  end
end

list = MyList.new(1, 2, 3, 4)

p list.my_all? { |e| e < 5 }
p list.my_all? { |e| e > 5 }
p list.my_any? { |e| e == 2 }
p list.my_any? { |e| e == 5 }
p list.my_filter(&:even?)
