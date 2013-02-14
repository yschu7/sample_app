#!/usr/bin/env ruby
require_relative 'ch08-1'
# A singleton is a class that has only a single instance. Singletons
# can be used to store global program state within an object-oriented
# framework and can be useful alternatives to class methods and class
# variables.
# 在Ruby標準程式庫中有一個Singleton模組，可以很快實現Single Pattern。
# 只要require 'singleton'，並include Singleton，就會定義一個名為instance的
# 類別方法，它不帶引數並返回該類別的單一實例。另外要定義一個initialize方法來執
# 行這個單實例的初始化，不過要注意此方法不可以有任何參數。
require 'singleton'         # Singleton module is not built-in

class PointStats            # Define a class
  include Singleton         # Make it a singleton

  def initialize            # A normal initialization method
    @n, @totalX, @totalY = 0, 0.0, 0.0
  end

  def record(point)           # Record a new point
    @n += 1
    @totalX += point.x
    @totalY += point.y
  end

  def report                  # Report point statistics
    puts "Number of points created: #@n"
    puts "Average X coordinate: #{@totalX/@n}"
    puts "Average Y coordinate: #{@totalY/@n}"
  end
end

# The module Singleton automatically creates the instance class method
# for us, and we invoke the regular instance method record on that
# singleton instance.
# 不需要也不可以使用PointStats.new來建立此單一實例，必須使用instance方法。
# In the Point class:
class Point
   def initialize(x,y)
     @x,@y = x,y
     PointStats.instance.record(self)
   end
end
p1 = Point.new(3,5)
p2 = Point.new(7,9)
# Similarly, when we want to query the point statistics:
puts "-"*30
PointStats.instance.report
#Number of points created: 2
#Average X coordinate: 5.0
#Average Y coordinate: 7.0

