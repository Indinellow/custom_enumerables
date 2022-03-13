module Enumerable
  # Your code goes here
  def my_each
    for element in self do
      yield element
    end
    self
  end

  def my_each_with_index
    i=0
    for element in self do
      yield element, i
      i += 1
    end
    self
  end

  def my_select 
    result = []
    my_each {|element| result.push(element) if yield element}
    result
  end

  def my_all?
    check = true
    my_each { |element| check &&= false unless yield element }
    check
  end

  def my_any?
    check = false
    my_each { |element| check ||= true if yield element }
    check
  end

  def my_none?
    check = true
    my_each { |element| check &&= false if yield element }
    check
  end

  def my_count arg = nil
    count = 0
    return self.length if !block_given? && arg.nil?
    if block_given?
      my_each { |element| count += 1 if yield element}
    else 
      my_each { |element| count += 1 if element == arg}
    end
    count
  end

  def my_map
    return to_enum(:map) unless block_given?

    new_array = []
    my_each { |element| new_array.push( yield element)}
    new_array
  end

  def my_inject memo = nil
    memo = self[0] if memo.nil?

    my_each do |element| 
      memo = yield memo, element
    end
    memo
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  include Enumerable
end
