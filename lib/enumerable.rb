# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Lint/ToEnumArguments


module Enumerable
  # 1.
  def my_all?(word = nil)
    all = true

    my_type = lambda do |f|
      my_each do |r|
        unless r.instance_of?(f)
          all = !all
          break
        end
      end
      all
    end

    if block_given? && word.nil? 
      my_each do |e|
        unless yield(e)
          all = !all
          break
        end
      end
      all
    elsif !block_given?
      if word == Regexp
        my_each do |e|
          if e != word
            all = !all
            break
          end
        end
        all
      elsif word == Numeric
        list.my_each do |e|
          unless e.is_a? word
            all = !all
            break
          end
        end
        all
      elsif word == Integer
        my_type.call(Integer)
      elsif word == Float
        my_type.call(Float)
      elsif word == Symbol
        my_type.call(Symbol)
      elsif word == String
        my_type.call(String)
      elsif word.instance_of?(Regexp)
        my_each do |e|
          unless word.match(e)
            all = !all
            break
          end
        end
        all
      elsif word.nil?
        my_each do |e|
          if !e || e.nil?
            all = !all
            break
          end
        end
        all
      elsif empty?
        all
      end
    else
      to_enum(__method__)
    end
  end

  # 2.
  def my_any?(word = nil)
    any = false

    my_type1 = lambda do |j|
      my_each do |d|
        if d.instance_of?(j)
          any = !any
          break
        end
      end
      any
    end

    if block_given? && word.nil?
      my_each do |e|
        if yield(e)
          any = !any
          break
        end
      end
      any
    elsif !block_given?
      if word == Regexp || word.instance_of?(Regexp)
        my_each do |e|
          if e == Regexp || e.instance_of?(Regexp)
            any = !any
            break
          end
        end
        any
      elsif word == Numeric
        my_each do |e|
          if e.is_a? word
            any = !any
            break
          end
        end
        any
      elsif word == Integer
        my_type1.call(Integer)
      elsif word == Float
        my_type1.call(Float)
      elsif word == Symbol
        my_type1.call(Symbol)
      elsif word.nil?
        my_each do |e|
          if e
            any = !any
            break
          end
        end
        any
      elsif empty?
        any
      end
    else
      to_enum(__method__)
    end
  end

  # 3.
  def my_filter
    if block_given?
      ary = []
      my_each do |e|
        ary << e if yield(e)
      end
      ary
    else
      to_enum(__method__)
    end
  end
end


# rubocop:enable Lint/ToEnumArguments
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity


# TEST SAMPLES AND ANSWERS
# arr = [1, 2, 3, 4, 5]
# ary = [1, 2, 4, 2]
# ary = []
